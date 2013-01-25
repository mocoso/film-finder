# encoding: utf-8
require 'spec_helper'

describe Search::BlinkBox do
  subject { Search::BlinkBox.new(query) }

  describe '#results', :vcr do
    context 'term for which they have multiple films to rent' do
      let(:query) { 'dark knight' }

      it 'should return the films' do
        subject.results.should == [
          Search::Result.new(
            :service => 'BlinkBox',
            :title   => 'The Dark Knight',
            :url     => 'http://www.blinkbox.com/Movies/28710/The-Dark-Knight',
            :price   => 'Rent -  £2.49'
          ),
          Search::Result.new(
            :service => 'BlinkBox',
            :title   => 'The Dark Knight Rises',
            :url    => 'http://www.blinkbox.com/Movies/37807/The-Dark-Knight-Rises',
            :price   => 'Rent -  £3.49'
          )
        ]
      end
    end
  end

  describe 'private' do
    let(:query) { 'dark knight' }

    describe '#search_url' do
      it 'should return search URL' do
        subject.send(:search_url).should == 'http://www.blinkbox.com/Search?Search=dark+knight'
      end
    end
  end
end
