# encoding: utf-8
require 'spec_helper'

describe Search::Film4oD do
  subject { Search::Film4oD.new(query) }

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
            :service    => 'Film4oD',
            :title      => 'The Dark Knight Rises',
            :url        => 'http://film4od.film4.com/Films/D/The-Dark-Knight-Rises/',
            :image_url  => 'http://content.film4od.com/Images/2012/11/29/portrait130x184/FF-00002660-IM-01portrait130x184.png',
            :price      => '£3.99'
          ),
          Rental.new(
            :service    => 'Film4oD',
            :title      => 'The Dark Knight',
            :url        => 'http://film4od.film4.com/Films/D/The-Dark-Knight/',
            :image_url  => 'http://content.film4od.com/Images/2012/6/6/portrait130x184/FF-00109368-IM-01portrait130x184.png',
            :price      => '£2.75'
          ),
          Rental.new(
            :service    => 'Film4oD',
            :title      => 'Batman: The Dark Knight Returns Part 1',
            :url        => 'http://film4od.film4.com/Films/B/Batman-The-Dark-Knight-Returns-Part-1/',
            :image_url  => 'http://content.film4od.com/Images/2012/11/15/portrait130x184/FF-00002653-IM-01portrait130x184.png',
            :price      => '£3.49'
          )
        ]
      end
    end
  end

  describe 'private' do
    let(:query) { 'dark knight' }

    describe '#search_url' do
      it 'should return search URL' do
        subject.send(:search_url).should == 'http://film4od.film4.com/Search/?searchQuery=dark+knight'
      end
    end
  end
end
