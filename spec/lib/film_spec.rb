require 'spec_helper'

describe Film do
  describe 'number_of_words_matching_query' do
    subject { Film.new('Batman: The Dark Knight Returns Part 1', :rentals => []) }

    it 'should match words even if they are different case and punctuation' do
      subject.number_of_words_matching_query('batman knight').should == 2
    end

    it 'should be 0 if no words in query match one in the title' do
      subject.number_of_words_matching_query('benny and june').should == 0
    end
  end
end
