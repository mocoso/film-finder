require 'spec_helper'

describe Source::ItunesPriceAdapter do
  describe '#prices' do
    let(:sd_rental_price) { 2.99 }
    let(:hd_rental_price) { 3.99 }
    let(:sd_purchase_price) { 7.99 }
    let(:hd_purchase_price) { 8.99 }

    subject {
      Source::ItunesPriceAdapter.new(
        'trackRentalPrice'    => sd_rental_price,
        'trackHdRentalPrice'  => hd_rental_price,
        'trackPrice'          => sd_purchase_price,
        'trackHdPrice'        => hd_purchase_price
      )
    }

    it 'should return purchase and rental price' do
      expect(subject.prices).to eq [
        Price.new('Rent SD £2.99'),
        Price.new('Rent HD £3.99'),
        Price.new('Buy SD £7.99'),
        Price.new('Buy HD £8.99')
      ]
    end

    context 'when it is only available to buy in a series' do
      subject {
        Source::ItunesPriceAdapter.new(
          'collectionPrice'   => 1.89,
          'trackPrice'        => -1.0,
          'collectionHdPrice' => 2.49,
          'trackHdPrice'      => -1.0
        )
      }

      it 'should return purchase and rental price' do
        expect(subject.prices).to eq [
          Price.new('Buy SD £1.89'),
          Price.new('Buy HD £2.49')
        ]
      end
    end

    context 'when there are duplicate prices' do
      subject {
        Source::ItunesPriceAdapter.new(
          'collectionPrice'   => 1.89,
          'trackPrice'        => 1.89
        )
      }

      it 'should return a single price' do
        expect(subject.prices).to eq [Price.new('Buy SD £1.89')]
      end
    end
    context 'when it is not available to buy or rent' do
      subject { Source::ItunesPriceAdapter.new({}) }

      it 'should return no prices' do
        expect(subject.prices).to eq []
      end
    end
  end
end
