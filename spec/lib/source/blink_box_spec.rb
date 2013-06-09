require 'spec_helper'

describe Source::BlinkBox do
  describe '#search_url' do
    specify do
      subject.search_url('dark knight').should ==
        'http://www.blinkbox.com/Search?Search=dark+knight'
    end
  end

  describe 'fragment methods' do
    describe '#rental_title' do
      it 'should extract the title from the fragment' do
        subject.rental_title(fragment).should == 'The Dark Knight'
      end
    end

    describe '#rental_url' do
      it 'should extract the url from the fragment' do
        subject.rental_url(fragment).should ==
          'http://www.blinkbox.com/Movies/28710/The-Dark-Knight'
      end
    end

    describe '#rental_image_url' do
      it 'should extract the rental image URL from the fragment' do
        subject.rental_image_url(fragment).should ==
          'http://cdn3.blinkboxmedia.com/i/contentasset31/000/028/710/s3cqssoh/v=130/w=180;h=100;rm=Crop;q=95/image.jpg'
      end
    end

    describe '#rental_price' do
      it 'should be unknown' do
        subject.rental_price(fragment).should == NoPrice.new('To rent')
      end
    end

    let(:fragment) {
      Nokogiri::HTML(%q{
<li class="result">
        <h3>
    <a href="/Movies/28710/The-Dark-Knight">The Dark Knight</a>
</h3>
<p class="thumb">
    <a href="/Movies/28710/The-Dark-Knight">
        <img alt="The Dark Knight" src="http://cdn3.blinkboxmedia.com/i/contentasset31/000/028/710/s3cqssoh/v=130/w=180;h=100;rm=Crop;q=95/image.jpg" width="180" height="100" /></a>
</p>
    <dl class="meta">
        <dt>Classification</dt>
        <dd  class="first-child">CERT 12</dd>
            <dt>Duration</dt>
            <dd>2 HRS 32 MINS</dd>
    </dl>
<p class="synopsis">Why So Serious?</p>
    <div class="genres">
        <h4>
            Genres</h4>
        <ul>
                <li>Action</li>
                <li>Sci-Fi</li>
                <li class="last">Thriller</li>
        </ul>
    </div>
<div class="actions">
    <h4>
        Actions</h4>
    <ul>
        <li class="save"><a class="add" title="Watch later" href="/Area/Profile/Bookmark/Add?id=28710&amp;kind=Movie"><span>Watch later</span></a></li>
    </ul>
</div>

    </li>}
      )
    }
  end
end
