module Source
  class BlinkBox
    def name
      'BlinkBox'
    end

    def url
      'http://www.blinkbox.com/'
    end

    def search_url(query)
      "http://www.blinkbox.com/Search?#{{ 'Search' => query }.to_query}"
    end

    def rental_fragments(html_page)
      Nokogiri::HTML(html_page).css('#results li.result')
    end

    def rental_title(rental_fragment)
      rental_fragment.css('h3').first.content.strip
    end

    def rental_url(rental_fragment)
      rental_fragment.css('h3 a').first.attributes['href'].value
    end

    def rental_image_url(rental_fragment)
      rental_fragment.css('.thumb img').first.attributes['src'].value
    end

    def rental_price(rental_fragment)
      Price.new(rental_fragment.css('li.purchase, li.watch').first.content.strip)
    end
  end
end
