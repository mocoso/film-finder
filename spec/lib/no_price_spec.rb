require 'spec_helper.rb'

describe NoPrice do
  describe '#display?' do
    specify { NoPrice.new('Not available from Blinkbox').display?.should == false }
  end
end

