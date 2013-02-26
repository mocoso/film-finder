module Source
  class Film4oD
    def name
      'Film4oD'
    end

    def url
      'http://film4od.film4.com/'
    end

    def search_url(query)
      "http://film4od.film4.com/Search/?#{{ 'searchQuery' => query }.to_query}"
    end

    def rental_fragments(page)
      Nokogiri::HTML(page).css('.searchResults li.filmResult')
    end

    def rental_title(rental_fragment)
      rental_fragment.css('h3').first.content.strip
    end

    def rental_url(rental_fragment)
      "http://film4od.film4.com#{rental_fragment.css('h3 a').first.attributes['href'].value}"
    end

    def rental_image_url(rental_fragment)
      rental_fragment.css('img').first.attributes['src'].value
    end

    def rental_price(rental_fragment)
      Price.new(rental_fragment.css('.filmControls
strong').first.content.strip)
    end
  end
end
