module Source
  class ItunesPriceAdapter
    def initialize(result)
      self.result = result
    end

    def prices
      prices = []
      if result['trackRentalPrice']
        prices << Price.new("Rent SD £#{result['trackRentalPrice']}")
      end

      if result['trackHdRentalPrice']
        prices << Price.new("Rent HD £#{result['trackHdRentalPrice']}")
      end

      if result['trackPrice']
        prices << Price.new("Buy SD £#{result['trackPrice']}")
      end

      if result['trackHdPrice']
        prices << Price.new("Buy HD £#{result['trackHdPrice']}")
      end

      prices
    end

    private
    attr_accessor :result
  end
end
