# encoding: utf-8
require 'spec_helper'

describe Rental do
  describe '#price_in_pence' do
    it 'should extract amount from price which includes amount in pounds' do
      Rental.new(:price => 'From £3.49').price_in_pence.should == 349
    end

    it 'should be zero when it cannot be identifed' do
      Rental.new(:price => 'Foo').price_in_pence.should == 0
    end
  end
end
