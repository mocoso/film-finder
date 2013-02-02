module Source
  class BBCIplayer
    def name
      'BBC iPlayer'
    end

    def url
      'http://www.bbc.co.uk/iplayer/'
    end

    def search_url(query)
      "http://www.bbc.co.uk/iplayer/search?#{{ 'q' => query }.to_query}"
    end

    def rental_fragments(html_page)
     # Nokogiri::HTML(html_page).css('.result-list div.episode-info')
      Nokogiri::HTML(html_page).xpath("//*[contains(@class,'result-list')]//div[contains(@class,'episode-info')][h3/a[not(@class)]]")
    end

    def rental_title(rental_fragment)
      rental_fragment.css('a').first.attributes['title'].value
    end

    def rental_url(rental_fragment)
      "http://www.bbc.co.uk#{rental_fragment.css('a').first.attributes['href'].value}"
    end

    def rental_image_url(rental_fragment)
      rental_fragment.css('img').first.attributes['src'].value
    end

    def rental_price(rental_fragment)
      Price.new 'Free'
    end
  end
end
