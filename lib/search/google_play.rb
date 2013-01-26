require 'open-uri'

module Search
  class GooglePlay < BaseService

    private
    def rental_fragments
      search_doc.css('li.search-results-item')
    end

    def service_name
      'Google Play'
    end

    def title(rental_fragment)
      rental_fragment.css('.title').first.content.strip
    end

    def url(rental_fragment)
      "https://play.google.com#{rental_fragment.css('a.title').first.attributes['href'].value}"
    end

    def price(rental_fragment)
      rental_fragment.css('.buy-button-price').first.content.strip
    end

    def search_url
      "https://play.google.com/store/search?#{{ 'q' => query, 'c' => 'movies'}.to_query}"
    end
  end
end
