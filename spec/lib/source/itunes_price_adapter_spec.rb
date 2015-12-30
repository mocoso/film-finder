require 'spec_helper'

describe Source::ItunesPriceAdapter do
  describe '#prices' do
    let(:rental_price) { '2.99' }
    let(:purchase_price) { '4.99' }

    subject {
      Source::ItunesPriceAdapter.new(
        'trackRentalPrice'  => rental_price,
        'trackPrice'        => purchase_price
      )
    }

    it 'should return purchase and rental price' do
      subject.prices.should == [
        Price.new('Rent from £2.99'),
        Price.new('Buy from £4.99')
      ]
    end

    context 'when it is not available to rent' do
      let(:rental_price) { nil }

      it 'should return the purchase price' do
        subject.prices.should == [
          Price.new('Buy from £4.99')
        ]
      end
    end
  end
end
