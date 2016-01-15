module Source
  class BFIPlayer
    def name
      'BFI Player'
    end

    def url
      'http://player.bfi.org.uk'
    end

    def search(query)
      raw_results(query).each_with_index.map { |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result[:title]),
          :url => result[:url],
          :image_url => result[:image_url],
          :prices => result[:free] ? [Price.new('Free')] : [],
          :certificate => result[:certificate],
          :type => result[:certificate].present? ? Rental::FILM_TYPE : nil,
          :year => result[:year],
          :length_in_minutes => result[:running_time_in_minutes],
          :search_rank => i
      }
    end

    private
    def raw_results(query)
      BFIPlayerSearch::Search.new.search(query)
    end
  end
end

