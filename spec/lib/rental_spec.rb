# utf-8
require 'spec_helper'

describe Rental do
  describe '#<=>' do
    let(:no_priced) { Rental.new :price => NoPrice.new('To rent') }
    let(:high_priced) { Rental.new :price => Price.new('£5.99') }
    let(:low_priced) { Rental.new :price => Price.new('£0.99') }

    specify { (no_priced <=> high_priced).should == 1 }
    specify { (high_priced <=> low_priced).should == 1 }
    specify { (low_priced <=> high_priced).should == -1 }
    specify { (high_priced <=> no_priced).should == -1 }
  end
end

