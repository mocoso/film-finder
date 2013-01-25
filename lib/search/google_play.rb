require 'open-uri'

module Search
  class GooglePlay < BaseService

    private
    def result_fragments
      search_doc.css('li.search-results-item')
    end

    def service_name
      'Google Play'
    end

    def title(result_fragment)
      result_fragment.css('.title').first.content.strip
    end

    def url(result_fragment)
      "https://play.google.com#{result_fragment.css('a.title').first.attributes['href'].value}"
    end

    def price(result_fragment)
      result_fragment.css('.buy-button-price').first.content.strip
    end

    def search_url
      "https://play.google.com/store/search?#{{ 'q' => query, 'c' => 'movies'}.to_query}"
    end
  end
end
