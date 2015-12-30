module Source
  class ItunesPriceAdapter
    def initialize(result)
      self.result = result
    end

    def price
      if result['trackRentalPrice']
        Price.new("From £#{result['trackRentalPrice']}")
      elsif result['trackPrice']
        Price.new("From £#{result['trackPrice']}")
      end
    end

    private
    attr_accessor :result
  end
end
