require 'google_play_search'

module Source
  class GooglePlay
    MAX_NUMBER_OF_RESULTS = 5

    def name
      'Google Play'
    end

    def url
      'https://play.google.com/store/movies'
    end

    def search(query)
      available_to_rent_results(query).take(MAX_NUMBER_OF_RESULTS).each_with_index.map { |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result.name),
          :url => result.url,
          :image_url => result.logo_url,
          :prices => [Price.new("From #{result.price}")],
          :image_quality_rank => 1,
          :search_rank => i
      }
    end

    def raw_results(query)
      GooglePlaySearch::Search.new(:category => 'movies').search(query)
    end

    def available_to_rent_results(query)
      raw_results(query).reject { |r| r.price == '0' }
    end
  end
end
