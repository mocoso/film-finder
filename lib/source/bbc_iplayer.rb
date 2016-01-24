module Source
  class BBCIplayer
    MAX_NUMBER_OF_RESULTS = 5

    def name
      'BBC iPlayer'
    end

    def url
      'http://www.bbc.co.uk/iplayer'
    end

    def search(query)
      available_results(query).take(MAX_NUMBER_OF_RESULTS).each_with_index.map { |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result[:title]),
          :url => result[:url],
          :image_url => result[:image_url],
          :prices => [Price.new('Free')],
          :image_quality_rank => 2,
          :search_rank => i
      }
    end

    private
    def raw_results(query)
      Rails.cache.fetch("#{self.class.name}::search::#{query}", expires_in: 1.hour) do
        BBCIplayerSearch::Search.new.search(query)
      end
    end

    def available_results(query)
      raw_results(query).select { |r| r[:available] }
    end
  end
end
