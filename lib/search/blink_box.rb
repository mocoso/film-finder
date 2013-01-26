require 'open-uri'

module Search
  class BlinkBox < BaseService

    private
    def result_fragments
      search_doc.css('#results li.result')
    end

    def service_name
      'BlinkBox'
    end

    def title(result_fragment)
      result_fragment.css('h3').first.content.strip
    end

    def url(result_fragment)
      result_fragment.css('h3 a').first.attributes['href'].value
    end

    def price(result_fragment)
      result_fragment.css('li.purchase, li.watch').first.content.strip
    end

    def search_url
      "http://www.blinkbox.com/Search?#{{ 'Search' => query }.to_query}"
    end
  end
end
