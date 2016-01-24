module Source
  class BFIPlayer
    MAX_NUMBER_OF_RESULTS = 10

    def name
      'BFI Player'
    end

    def url
      'http://player.bfi.org.uk'
    end

    def search(query)
      raw_results(query).take(MAX_NUMBER_OF_RESULTS).each_with_index.map { |result, i|
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
          :image_quality_rank => 2,
          :search_rank => i
      }
    end

    private
    def raw_results(query)
      BFIPlayerSearch::Search.new.search(query)
    end
  end
end

