require 'spec_helper'

describe Source::Itunes do
  describe '#search_url' do
    specify do
      subject.search_url('dark knight').should ==
        'https://itunes.apple.com/search?country=gb&limit=200&term=dark+knight'
    end
  end

  describe 'fragment methods' do
    describe '#rental_title' do
      it 'should extract the title from the fragment' do
        subject.rental_title(fragment).should == 'The Dark Knight Rises'
      end
    end

    describe '#rental_url' do
      it 'should extract the rental_url from the fragment' do
        subject.rental_url(fragment).should ==
          'https://itunes.apple.com/gb/movie/the-dark-knight-rises/id567661493?uo=4'
      end
    end

    describe '#rental_image_url' do
      it 'should extract the image_url from the fragment' do
        subject.rental_image_url(fragment).should ==
          'http://a4.mzstatic.com/us/r1000/119/Video/v4/ed/10/35/ed103597-90c1-3d1c-197c-a68532b47a06/poster.100x100-75.jpg'
      end
    end

    describe '#rental_price' do
      it 'should extract the price from the fragment' do
        subject.rental_price(fragment).should == Price.new('£9.99')
      end
    end

    let(:fragment) {
      {
        'wrapperType'             => 'track',
        'kind'                    => 'feature-movie',
        'collectionId'            => 582838896,
        'trackId'                 => 567661493,
        'artistName'              => 'Christopher Nolan',
        'collectionName'          => 'The Dark Knight Trilogy',
        'trackName'               => 'The Dark Knight Rises',
        'collectionCensoredName'  => 'The Dark Knight Trilogy',
        'trackCensoredName'       => 'The Dark Knight Rises',
        'collectionViewUrl'       => 'https://itunes.apple.com/gb/movie/the-dark-knight-rises/id567661493?uo=4',
        'trackViewUrl'            => 'https://itunes.apple.com/gb/movie/the-dark-knight-rises/id567661493?uo=4',
        'previewUrl'              => 'http://a1705.v.phobos.apple.com/us/r1000/092/Video/v4/14/d1/b2/14d1b251-7195-ffef-9ad8-7698fffa7c39/mzvf_4404176060638275489.640x354.h264lc.D2.p.m4v',
        'artworkUrl30'            => 'http://a2.mzstatic.com/us/r1000/119/Video/v4/ed/10/35/ed103597-90c1-3d1c-197c-a68532b47a06/poster.30x30-50.jpg',
        'artworkUrl60'            => 'http://a4.mzstatic.com/us/r1000/119/Video/v4/ed/10/35/ed103597-90c1-3d1c-197c-a68532b47a06/poster.60x60-50.jpg',
        'artworkUrl100'           => 'http://a4.mzstatic.com/us/r1000/119/Video/v4/ed/10/35/ed103597-90c1-3d1c-197c-a68532b47a06/poster.100x100-75.jpg',
        'collectionPrice'         => '9.99',
        'trackPrice'              => '9.99',
        'releaseDate'             => '2012-07-20T07:00:00Z',
        'collectionExplicitness'  => 'notExplicit',
        'trackExplicitness'       => 'notExplicit',
        'discCount'               => 1,
        'discNumber'              => 1,
        'trackCount'              => 3,
        'trackNumber'             => 3,
        'trackTimeMillis'         => 9869375,
        'country'                 => 'GBR',
        'currency'                => 'GBP',
        'primaryGenreName'        => 'Action & Adventure',
        'contentAdvisoryRating'   => '12',
        'longDescription'         => %{Warner Bros. Pictures' and Legendary Pictures' "The Dark Knight Rises" is the epic conclusion to filmmaker Christopher Nolan's Dark Knight trilogy. It has been eight years since Batman vanished into the night, turning, in that instant, from hero to fugitive. Assuming the blame for the death of D.A. Harvey Dent, the Dark Knight sacrificed everything for what he and Commissioner Gordon both hoped was the greater good. For a time the lie worked, as criminal activity in Gotham City was crushed under the weight of the anti-crime Dent Act. But everything will change with the arrival of a cunning cat burglar with a mysterious agenda. Far more dangerous, however, is the emergence of Bane, a masked terrorist whose ruthless plans for Gotham drive Bruce out of his self-imposed exile. But even if he dons the cape and cowl again, Batman may be no match for Bane.},
      }
    }
  end
end
