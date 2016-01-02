require 'spec_helper'

describe Film do
  describe 'number_of_words_matching_query' do
    subject { Film.new(Title.new('X-men and Batman: The Dark Knight Returns Part 1'), :rentals => []) }

    it 'should match words even if they are different case and punctuation' do
      subject.number_of_words_matching_query('batman knight').should == 2
    end

    it 'should match words even if the differ by a hyphen' do
      subject.number_of_words_matching_query('xmen').should == 1
    end

    it 'should be 0 if no words in query match one in the title' do
      subject.number_of_words_matching_query('water boy').should == 0
    end
  end
end
