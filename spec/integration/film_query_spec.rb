require 'spec_helper'

describe FilmQuery
  describe '#films', :vcr do
    let(:the_dark_knight_1_google_play) {
      Rental.new \
        :service    => 'Google Play',
        :title      => 'The Dark Knight',
        :url        => 'https://play.google.com/store/movies/details/The_Dark_Knight?id=rl4C51VsNRU&feature=search_result',
        :image_url  => 'https://lh6.ggpht.com/OBtDPQtLEGRYfkRmmw_EEuqvP_wI4k1HTXqNO8KNL-5gRe0k0OcoF7AeF3mQuJwofgnVSA',
        :price      => Price.new('£2.49 Rent')
    }

    let(:the_dark_knight_2_google_play) {
      Rental.new \
        :service    => 'Google Play',
        :title      => 'The Dark Knight',
        :url        => 'https://play.google.com/store/movies/details/The_Dark_Knight?id=TQfcgaNdBCA&feature=search_result',
        :image_url  => 'https://lh6.ggpht.com/DlTAHuUL3EyFjJohjURAWhhhqsb_DGO8fspZ2DVxcq1rHI-HfMpPlqz8ouscCBEIdn4',
        :price      => Price.new('From £2.49')
    }

    let(:the_dark_knight_film4o_d) {
      Rental.new \
        :service    => 'Film4oD',
        :title      => 'The Dark Knight',
        :url        => 'http://film4od.film4.com/Films/D/The-Dark-Knight/',
        :image_url  => 'http://onlinemovies-cache.virginmedia.com/Images/2012/6/6/portrait130x184/FF-00109368-IM-01portrait130x184.png',
        :price      => Price.new('£2.75')
    }

    let(:the_dark_knight_blink_box) {
      Rental.new \
        :service    => 'BlinkBox',
        :title      => 'The Dark Knight',
        :url        => 'http://www.blinkbox.com/Movies/28710/The-Dark-Knight',
        :image_url  => 'http://cdn3.blinkboxmedia.com/i/contentasset31/000/028/710/s3cqssoh/v=130/w=180;h=100;rm=Crop;q=95/image.jpg',
        :price      => NoPrice.new('To rent')
    }

    let(:the_dark_knight) {
      Film.new \
        'The Dark Knight',
        :rentals => [
          the_dark_knight_1_google_play,
          the_dark_knight_2_google_play,
          the_dark_knight_film4o_d,
          the_dark_knight_blink_box
        ]
    }

    it "should return a list of films from all sources when searching for 'dark knight'" do
      FilmQuery.new('dark knight').films.first.should == the_dark_knight
  end
end
