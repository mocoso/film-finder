module Search
  class BaseService
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
      unless @search_doc
        # Open then read required because otherwise nokogiri mangles UTF-8
        # characters when searching Google Play.
        #
        # See http://stackoverflow.com/questions/2572396/nokogiri-open-uri-and-unicode-characters
        # for more info.
        html = open search_url
        @search_doc = Nokogiri::HTML html.read
      end

      @search_doc
    end

    def result(result_fragment)
      Search::Result.new \
        :service => service_name,
        :title   => title(result_fragment),
        :url     => url(result_fragment),
        :price   => price(result_fragment)
    end
  end
end
