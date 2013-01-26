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

    def request
      @request ||= Typhoeus::Request.new(search_url, :proxy => ENV['HTTP_PROXY'] )
    end

    private
    attr_accessor :query

    def search_doc
      @search_doc ||= Nokogiri::HTML(request.response.body)
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
