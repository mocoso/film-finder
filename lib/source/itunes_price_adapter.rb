module Source
  class ItunesPriceAdapter
    def initialize(result)
      self.result = result
    end

    def prices
      prices = []
      if result['trackRentalPrice']
        prices << Price.new("Rent from £#{result['trackRentalPrice']}")
      end

      if result['trackPrice']
        prices << Price.new("Buy from £#{result['trackPrice']}")
      end
      prices
    end

    private
    attr_accessor :result
  end
end
