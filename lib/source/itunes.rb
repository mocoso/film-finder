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
      film_and_tv_results(query).map.each_with_index { |result, i|
        Rental.new \
          :service => name,
          :title => Title.new(result['trackCensoredName']),
          :url => result['trackViewUrl'],
          :image_url => result['artworkUrl100'],
          :year => result['releaseDate'] && Date.parse(result['releaseDate']).year,
          :certificate => result['contentAdvisoryRating'],
          :prices => ItunesPriceAdapter.new(result).prices,
          :search_rank => i
      }.reject { |r|
        r.prices.empty?
      }
    end

    private
    def raw_results(query)
      ITunesSearchAPI.search(:term => query, :country => 'GB')
    end

    def film_and_tv_results(query)
      raw_results(query).select { |f| FILM_AND_TV_KINDS.include? f['kind'] }
    end
  end
end
