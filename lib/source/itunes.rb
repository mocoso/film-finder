module Source
  class Itunes
    FILM_AND_TV_KINDS = ['feature-movie', 'tv-episode']

    def name
      'iTunes'
    end

    def url
      'http://www.apple.com/itunes/'
    end

    def search_url(query)
      # Collect as many results as possible because iTunes does not allow you to
      # search just movies and tv episodes and so we wil need to filter out all
      # the songs etc. after we have fetched
      "https://itunes.apple.com/search?#{{ 'country' => 'gb', 'limit' => 200, 'term' => query }.to_query}"
    end

    def rental_fragments(page)
      JSON.parse(page)['results'].select { |f| FILM_AND_TV_KINDS.include? f['kind'] }
    end

    def rental_title(rental_fragment)
      rental_fragment['trackCensoredName']
    end

    def rental_url(rental_fragment)
      rental_fragment['trackViewUrl']
    end

    def rental_image_url(rental_fragment)
      rental_fragment['artworkUrl100']
    end

    def rental_price(rental_fragment)
      Price.new "£#{rental_fragment['trackPrice']}"
    end
  end
end
