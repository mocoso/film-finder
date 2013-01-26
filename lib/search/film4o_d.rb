require 'open-uri'

module Search
  class Film4oD < BaseService

    private
    def rental_fragments
      search_doc.css('.searchResults li.filmResult')
    end

    def service_name
      'Film4oD'
    end

    def title(rental_fragment)
      rental_fragment.css('h3').first.content.strip
    end

    def url(rental_fragment)
      "http://film4od.film4.com#{rental_fragment.css('h3 a').first.attributes['href'].value}"
    end

    def price(rental_fragment)
      rental_fragment.css('.filmControls strong').first.content.strip
    end

    def search_url
      "http://film4od.film4.com/Search/?#{{ 'searchQuery' => query }.to_query}"
    end
  end
end
