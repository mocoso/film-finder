# encoding: utf-8
require 'spec_helper'

describe Search::GooglePlay do
  subject { Search::GooglePlay.new(query) }

  describe '#results', :vcr do
    context 'term for which they have multiple films to rent' do
      let(:query) { 'dark knight' }

      it 'should return the films' do
        subject.results.slice(0,2).should == [
          Search::Result.new(
            :service => 'Google Play',
            :title   => 'The Dark Knight',
            :url     => 'https://play.google.com/store/movies/details/The_Dark_Knight?id=TQfcgaNdBCA&feature=search_result',
            :price   => 'From £2.49'
          ),
          Search::Result.new(
            :service => 'Google Play',
            :title   => 'The Dark Knight Rises',
            :url     => 'https://play.google.com/store/movies/details/The_Dark_Knight_Rises?id=qT3d-QcF7DA&feature=search_result',
            :price   => 'From £3.49'
          )
        ]
      end
    end
  end

  describe 'private' do
    let(:query) { 'dark knight' }

    describe '#search_url' do
      it 'should return search URL' do
        subject.send(:search_url).should == 'https://play.google.com/store/search?c=movies&q=dark+knight'
      end
    end
  end
end
