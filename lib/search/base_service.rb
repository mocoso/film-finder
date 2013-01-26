module Search
  class BaseService
    def initialize(query)
      self.query = query
    end

    def rentals
      @rentals ||= rental_fragments.map do |fragment|
        rental fragment
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

    def rental(rental_fragment)
      Rental.new \
        :service => service_name,
        :title   => title(rental_fragment),
        :url     => url(rental_fragment),
        :price   => price(rental_fragment)
    end
  end
end
