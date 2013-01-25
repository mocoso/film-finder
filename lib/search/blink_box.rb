require 'open-uri'

module Search
  class BlinkBox
    def initialize(query)
      self.query = query
    end

    def results
      @results ||= search_doc.css('#results li.result').map do |fragment|
        Search::Result.new \
          :title => fragment.css('h3').first.content.strip
      end
    end

    private
    attr_accessor :query

    def search_doc
      @search_doc ||= Nokogiri::HTML(open(search_url))
    end

    def search_url
      "http://www.blinkbox.com/Search?#{{ 'Search' => query }.to_query}"
    end
  end
end
