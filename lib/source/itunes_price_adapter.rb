module Source
  class ItunesPriceAdapter
    def initialize(result)
      self.result = result
    end

    def prices
      prices = []

      if valid_amount?(result['trackRentalPrice'])
        prices << "Rent SD £#{result['trackRentalPrice']}"
      end

      if valid_amount?(result['trackHdRentalPrice'])
        prices << "Rent HD £#{result['trackHdRentalPrice']}"
      end

      if valid_amount?(result['trackPrice'])
        prices << "Buy SD £#{result['trackPrice']}"
      end

      if valid_amount?(result['trackHdPrice'])
        prices << "Buy HD £#{result['trackHdPrice']}"
      end

      if valid_amount?(result['collectionPrice'])
        prices << "Buy series SD £#{result['collectionPrice']}"
      end

      if valid_amount?(result['collectionHdPrice'])
        prices << "Buy series HD £#{result['collectionHdPrice']}"
      end

      prices.map { |p| Price.new(p) }.uniq { |p| p.in_pence }
    end

    private
    attr_accessor :result

    def valid_amount?(amount)
      amount && amount > 0
    end
  end
end
