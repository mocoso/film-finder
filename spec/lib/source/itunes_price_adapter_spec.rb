require 'spec_helper'

describe Source::ItunesPriceAdapter do
  describe '#price' do
    let(:rental_price) { '2.99' }
    let(:purchase_price) { '4.99' }

    subject {
      Source::ItunesPriceAdapter.new(
        'trackRentalPrice'  => rental_price,
        'trackPrice'        => purchase_price
      )
    }

    it 'should return rental price' do
      subject.price.should == Price.new('From £2.99')
    end

    context 'when it is not available to rent' do
      let(:rental_price) { nil }

      it 'should return the purchase price' do
        subject.price.should == Price.new('From £4.99')
      end
    end
  end
end
