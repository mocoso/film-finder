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
      GooglePlaySearch::Search.new(:category => 'movies').search(query).map { |result|
        Rental.new \
          :service => name,
          :title => result.name,
          :url => result.url,
          :image_url => result.logo_url,
          :price => Price.new(result.price)
      }
    end
  end
end
