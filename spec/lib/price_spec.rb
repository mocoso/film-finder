# encoding: utf-8
require 'spec_helper.rb'

describe Price do
  describe '#to_s' do
    specify { Price.new('From £3.99').to_s.should == 'From £3.99' }
  end

  describe '#<=>' do
    let(:high)        { Price.new('From £3.99') }
    let(:low)         { Price.new('Rent for £2.49') }
    let(:another_low) { Price.new('£2.49') }
    let(:free)        { Price.new('Free') }

    specify { (high <=> low).should == 1 }
    specify { (high <=> free).should == 1 }
    specify { (free <=> low).should == -1 }
    specify { (low <=> another_low).should == 0 }
  end
end
