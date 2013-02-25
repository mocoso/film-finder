require 'spec_helper'

describe FilmQuery
  describe '#films', :vcr do
    let(:the_dark_knight_blink_box) {
      Rental.new \
        :service    => 'BlinkBox',
        :title      => 'The Dark Knight',
        :url        => 'http://www.blinkbox.com/Movies/28710/The-Dark-Knight',
        :image_url  => 'http://cdn3.blinkboxmedia.com/i/contentasset30/000/028/710/ieoabmeo/v=113/w=180;h=100;rm=Crop;q=95/image.jpg',
        :price      => Price.new('Rent -  £2.49')
    }

    let(:the_dark_knight_1_google_play) {
      Rental.new \
        :service    => 'Google Play',
        :title      => 'The Dark Knight',
        :url        => 'https://play.google.com/store/movies/details/The_Dark_Knight?id=rl4C51VsNRU&feature=search_result',
        :image_url  => 'https://i.ytimg.com/vi/rl4C51VsNRU/movieposter.jpg',
        :price      => Price.new('£2.49 Rent')
    }

    let(:the_dark_knight_2_google_play) {
      Rental.new \
        :service    => 'Google Play',
        :title      => 'The Dark Knight',
        :url        => 'https://play.google.com/store/movies/details/The_Dark_Knight?id=TQfcgaNdBCA&feature=search_result',
        :image_url  => 'https://i.ytimg.com/vi/TQfcgaNdBCA/movieposter.jpg',
        :price      => Price.new('From £2.49')
    }

    let(:the_dark_knight_film4o_d) {
      Rental.new \
        :service    => 'Film4oD',
        :title      => 'The Dark Knight',
        :url        => 'http://film4od.film4.com/Films/D/The-Dark-Knight/',
        :image_url  => 'http://content.film4od.com/Images/2012/6/6/portrait130x184/FF-00109368-IM-01portrait130x184.png',
        :price      => Price.new('£2.75')
    }

    let(:the_dark_knight) {
      Film.new \
        'The Dark Knight',
        :rentals => [
          the_dark_knight_blink_box,
          the_dark_knight_1_google_play,
          the_dark_knight_2_google_play,
          the_dark_knight_film4o_d
        ]
    }

    it "should return a list of films from all sources when searching for 'dark knight'" do
      FilmQuery.new('dark knight').films.first.should == the_dark_knight
  end
end
