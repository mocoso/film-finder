require 'open-uri'

module Search
  class BlinkBox < BaseService

    private
    def rental_fragments
      search_doc.css('#results li.result')
    end

    def service_name
      'BlinkBox'
    end

    def title(rental_fragment)
      rental_fragment.css('h3').first.content.strip
    end

    def url(rental_fragment)
      rental_fragment.css('h3 a').first.attributes['href'].value
    end

    def image_url(rental_fragment)
      rental_fragment.css('.thumb img').first.attributes['src'].value
    end

    def price(rental_fragment)
      rental_fragment.css('li.purchase, li.watch').first.content.strip
    end

    def search_url
      "http://www.blinkbox.com/Search?#{{ 'Search' => query }.to_query}"
    end
  end
end
