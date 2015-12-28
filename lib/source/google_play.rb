module Source
  class GooglePlay
    def name
      'Google Play'
    end

    def url
      'https://play.google.com/store/movies'
    end

    def search(query)
      []
    end

    def search_url(query)
      "https://play.google.com/store/search?#{{ 'q' => query, 'c' => 'movies'}.to_query}"
    end

    def rental_fragments(page)
      Nokogiri::HTML(page).css('li.search-results-item')
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
      # Note: GooglePlay does not display a rental button for freely available
      # tv episodes/films
      buy_button = rental_fragment.css('.buy-button-price').first
      Price.new(buy_button ? buy_button.content.strip : '')
    end
  end
end
