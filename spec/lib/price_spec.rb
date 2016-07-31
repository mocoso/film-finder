require 'spec_helper.rb'

describe Price do
  describe '#to_s' do
    specify { expect(Price.new('From £3.99').to_s).to eq 'From £3.99' }
  end

  describe '#<=>' do
    let(:high)        { Price.new('From £3.99') }
    let(:low)         { Price.new('Rent for £2.49') }
    let(:another_low) { Price.new('£2.49') }
    let(:free)        { Price.new('Free') }

    specify { expect(high <=> low).to eq 1 }
    specify { expect(high <=> free).to eq 1 }
    specify { expect(free <=> low).to eq(-1) }
    specify { expect(low <=> another_low).to eq 0 }
  end
end
