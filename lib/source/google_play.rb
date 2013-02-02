module Source
  class GooglePlay
    def name
      'Google Play'
    end

    def url
      'https://play.google.com/store/movies'
    end

    def search_url(query)
      "https://play.google.com/store/search?#{{ 'q' => query, 'c' => 'movies'}.to_query}"
    end

    def rental_fragments(html_page)
      Nokogiri::HTML(html_page).css('li.search-results-item')
    end

    def rental_title(rental_fragment)
      rental_fragment.css('.title').first.content.strip
    end

    def rental_url(rental_fragment)
      "https://play.google.com#{rental_fragment.css('a.title').first.attributes['href'].value}"
    end

    def rental_image_url(rental_fragment)
      rental_fragment.css('.thumbnail img').first.attributes['src'].value
    end

    def rental_price(rental_fragment)
      Price.new(rental_fragment.css('.buy-button-price').first.content.strip)
    end
  end
end
