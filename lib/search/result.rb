# encoding: utf-8
module Search
  class Result
    def initialize(attributes)
      @attributes = attributes
    end

    def title
      attributes[:title]
    end

    def url
      attributes[:url]
    end

    def service
      attributes[:service]
    end

    def price
      attributes[:price]
    end

    def price_in_pence
      (price.match(/£(\d+\.\d*)/)[1].to_f * 100).to_i
    end

    def ==(other)
      self.attributes == other.attributes
    end

    protected
    attr_reader :attributes
  end
end
