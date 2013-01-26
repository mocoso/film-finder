require 'open-uri'

module Search
  class Film4oD < BaseService

    private
    def result_fragments
      search_doc.css('.searchResults li.filmResult')
    end

    def service_name
      'Film4oD'
    end

    def title(result_fragment)
      result_fragment.css('h3').first.content.strip
    end

    def url(result_fragment)
      "http://film4od.film4.com#{result_fragment.css('h3 a').first.attributes['href'].value}"
    end

    def price(result_fragment)
      result_fragment.css('.filmControls strong').first.content.strip
    end

    def search_url
      "http://film4od.film4.com/Search/?#{{ 'searchQuery' => query }.to_query}"
    end
  end
end
