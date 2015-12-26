module Source
  class BlinkBox
    def name
      'BlinkBox'
    end

    def url
      'http://www.blinkbox.com/'
    end

    def search_url(query)
      "http://www.blinkbox.com/search?#{{ 'Search' => query }.to_query}"
    end

    def rental_fragments(page)
      Nokogiri::HTML(page).css('#results li.result')
    end

    def rental_title(rental_fragment)
      rental_fragment.css('h3').first.content.strip
    end

    def rental_url(rental_fragment)
      u = URI.parse(extract_rental_path_or_url(rental_fragment))
      u.host ||= 'www.blinkbox.com'
      u.scheme ||= 'http'
      u.to_s
    end

    def rental_image_url(rental_fragment)
      rental_fragment.css('.thumb img').first.attributes['src'].value
    end

    def rental_price(rental_fragment)
      # BlinkBox don't currently include the price in their search results pages
      NoPrice.new('To rent')
    end

    private
    def extract_rental_path_or_url(rental_fragment)
      rental_fragment.css('h3 a').first.attributes['href'].value
    end
  end
end
