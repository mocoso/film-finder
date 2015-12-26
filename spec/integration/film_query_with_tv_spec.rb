require 'spec_helper'

describe FilmQuery
  describe '#films', :vcr do
    let(:eastenders_omnibus) {
      Rental.new \
        :service    => 'BBC iPlayer',
        :title      => 'EastEnders Omnibus: 03/02/2013',
        :url        => 'http://www.bbc.co.uk/iplayer/episode/b01qlgsr/EastEnders_Omnibus_03_02_2013/',
        :image_url  => 'http://ichef.bbci.co.uk/programmeimages/episode/b01qlgsr_120_68.jpg',
        :price      => Price.new('Free')
    }

    let(:eastenders) {
      Film.new \
        'EastEnders Omnibus: 03/02/2013',
        :rentals => [
          eastenders_omnibus
        ]
    }

    it "should return a list including tv programmes when searching for
'eastenders'" do
      FilmQuery.new('eastenders').films.include?(eastenders).should be_truthy
  end
end
