require 'itunes-search-api'

module Source
  class Itunes
    MAX_NUMBER_OF_RESULTS = 10
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
          :title => title_for_result(result),
          :url => result['trackViewUrl'],
          :image_url => result['artworkUrl100'],
          :year => result['releaseDate'] && Date.parse(result['releaseDate']).year,
          :certificate => result['contentAdvisoryRating'],
          :type => result['kind'] == 'feature-movie' ? Rental::FILM_TYPE : Rental::TV_EPISODE_TYPE,
          :length_in_minutes => result['trackTimeMillis'].present? ? (result['trackTimeMillis'] / 60000) : nil,
          :prices => ItunesPriceAdapter.new(result).prices,
          :image_quality_rank => 5,
          :search_rank => i
      }.reject { |r|
        r.prices.empty?
      }.take(MAX_NUMBER_OF_RESULTS)
    end

    private
    def raw_results(query)
      Rails.cache.fetch("#{self.class.name}::search::#{query}", expires_in: 1.hour) do
        ITunesSearchAPI.search(:term => query, :country => 'GB')
      end
    end

    def film_and_tv_results(query)
      raw_results(query).select { |f| FILM_AND_TV_KINDS.include? f['kind'] }
    end

    def title_for_result(result)
      if result['kind'] == 'feature-movie'
        Title.new(result['trackCensoredName'])
      else
        Title.new([result['collectionCensoredName'], result['trackCensoredName']].uniq.compact.join(': '))
      end
    end
  end
end
