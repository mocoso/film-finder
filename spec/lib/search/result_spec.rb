# encoding: utf-8
require 'spec_helper'

describe Search::Result do
  describe '#price_in_pence' do
    it 'should extract amount from price' do
      Search::Result.new(:price => 'From £3.49').price_in_pence.should == 349
    end
  end
end
