require 'open-uri'

module Search
  class BlinkBox
    def initialize(query)
      self.query = query
    end

    def results
      @results ||= result_fragments.map do |fragment|
        result fragment
      end
    end

    private
    attr_accessor :query

    def search_doc
      @search_doc ||= Nokogiri::HTML(open(search_url))
    end

    def result_fragments
      search_doc.css('#results li.result')
    end

    def result(result_fragment)
      Search::Result.new \
        :title => title(result_fragment),
        :url   => url(result_fragment),
        :price => price(result_fragment)
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
