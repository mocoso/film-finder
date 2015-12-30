require 'itunes-search-api'

module Source
  class Itunes
    FILM_AND_TV_KINDS = ['feature-movie', 'tv-episode']

    def name
      'iTunes'
    end

    def url
      'http://www.apple.com/itunes/'
    end

    def search(query)
      film_and_tv_available_to_rent_results(query).map { |result|
        Rental.new \
          :service => name,
          :title => result['trackCensoredName'],
          :url => result['trackViewUrl'],
          :image_url => result['artworkUrl100'],
          :price => price_for_result(result)
      }
    end

    private
    def raw_results(query)
      ITunesSearchAPI.search(:term => query, :country => 'GB')
    end

    def film_and_tv_results(query)
      raw_results(query).select { |f| FILM_AND_TV_KINDS.include? f['kind'] }
    end

    def film_and_tv_available_to_rent_results(query)
      film_and_tv_results(query).reject { |r| price_for_result(r).nil? }
    end

    def price_for_result(result)
      if result['trackRentalPrice']
        Price.new("From £#{result['trackRentalPrice']}")
      elsif result['trackPrice']
        Price.new("From £#{result['trackPrice']}")
      end
    end
  end
end
