require 'google_play_search'

module Source
  class GooglePlay
    def name
      'Google Play'
    end

    def url
      'https://play.google.com/store/movies'
    end

    def search(query)
      available_to_rent_results(query).map { |result|
        Rental.new \
          :service => name,
          :title => result.name,
          :url => result.url,
          :image_url => result.logo_url,
          :price => Price.new("From #{result.price}")
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
