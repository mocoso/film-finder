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
          :search_rank => i
      }
    end

    private
    def raw_results(query)
      BFIPlayerSearch::Search.new.search(query)
    end
  end
end

