require 'spec_helper'

describe Film do
  describe 'matches_query?' do
    subject { Film.new('The Dark Knight', :rentals => []) }

    it 'should be true if at least one word in the query matches one in the title' do
      subject.should be_matches_query('gotham knight')
    end

    it 'should not be true if no words in query match one in the title' do
      subject.should_not be_matches_query('benny and june')
    end
  end
end
