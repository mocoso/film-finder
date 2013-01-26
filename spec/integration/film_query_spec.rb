# encoding: utf-8
require 'spec_helper'

describe FilmQuery
  describe '#films', :vcr do
    let(:the_dark_knight_blink_box) {
      Search::Result.new \
        :service => 'BlinkBox',
        :title   => 'The Dark Knight',
        :url     => 'http://www.blinkbox.com/Movies/28710/The-Dark-Knight',
        :price   => 'Rent -  £2.49'
    }

    let(:the_dark_knight_1_google_play) {
      Search::Result.new \
        :service => 'Google Play',
        :title   => 'The Dark Knight',
        :url     => 'https://play.google.com/store/movies/details/The_Dark_Knight?id=rl4C51VsNRU&feature=search_result',
        :price   => '£2.49 Rent'
    }

    let(:the_dark_knight_2_google_play) {
      Search::Result.new \
        :service => 'Google Play',
        :title   => 'The Dark Knight',
        :url     => 'https://play.google.com/store/movies/details/The_Dark_Knight?id=TQfcgaNdBCA&feature=search_result',
        :price   => 'From £2.49'
    }

    let(:the_dark_knight_film4o_d) {
      Search::Result.new \
        :service => 'Film4oD',
        :title   => 'The Dark Knight',
        :url     => 'http://film4od.film4.com/Films/D/The-Dark-Knight/',
        :price   => '£2.75'
    }

    let(:the_dark_knight) {
      Film.new \
        'The Dark Knight',
        :results => [
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
