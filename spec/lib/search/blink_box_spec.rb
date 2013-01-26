# encoding: utf-8
require 'spec_helper'

describe Search::BlinkBox do
  subject { Search::BlinkBox.new(query) }

  describe '#rentals', :vcr do
    let(:hydra) { Typhoeus::Hydra.new }

    before(:each) do
      hydra.queue subject.request
      hydra.run
    end

    context 'term for which they have multiple films to rent' do
      let(:query) { 'dark knight' }

      it 'should return the films' do
        subject.rentals.should == [
          Rental.new(
            :service    => 'BlinkBox',
            :title      => 'The Dark Knight',
            :url        => 'http://www.blinkbox.com/Movies/28710/The-Dark-Knight',
            :image_url  => 'http://cdn3.blinkboxmedia.com/i/contentasset30/000/028/710/ieoabmeo/v=112/w=180;h=100;rm=Crop;q=95/image.jpg',
            :price      => 'Rent -  £2.49'
          ),
          Rental.new(
            :service    => 'BlinkBox',
            :title      => 'The Dark Knight Rises',
            :url        => 'http://www.blinkbox.com/Movies/37807/The-Dark-Knight-Rises',
            :image_url  => 'http://cdn3.blinkboxmedia.com/i/contentasset15/000/037/807/gtqjeb2w/v=112/w=180;h=100;rm=Crop;q=95/image.jpg',
            :price      => 'Rent -  £3.49'
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
