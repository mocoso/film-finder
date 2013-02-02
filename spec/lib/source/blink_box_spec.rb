# encoding=utf-8
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
      it 'should extract the title from the fragment' do
        subject.rental_url(fragment).should ==
          'http://www.blinkbox.com/Movies/28710/The-Dark-Knight'
      end
    end

    describe '#rental_image_url' do
      it 'should extract the title from the fragment' do
        subject.rental_image_url(fragment).should ==
          'http://cdn3.blinkboxmedia.com/i/contentasset30/000/028/710/ieoabmeo/v=113/w=180;h=100;rm=Crop;q=95/image.jpg'
      end
    end

    describe '#rental_price' do
      it 'should extract the title from the fragment' do
        subject.rental_price(fragment).should == Price.new('Rent - £2.49')
      end
    end

    let(:fragment) {
      Nokogiri::HTML(%q{
<li class="result">
        <h3>
    <a href="http://www.blinkbox.com/Movies/28710/The-Dark-Knight">The Dark Knight</a></h3>
<p class="thumb">
    <a href="http://www.blinkbox.com/Movies/28710/The-Dark-Knight">
        <img alt="The Dark Knight" src="http://cdn3.blinkboxmedia.com/i/contentasset30/000/028/710/ieoabmeo/v=113/w=180;h=100;rm=Crop;q=95/image.jpg" width="180" height="100" /></a>
</p>
    <dl class="meta">
        <dt>Classification</dt>
        <dd class="classification c12">12</dd>
        <dt>Released</dt>
        <dd>2008</dd>
            <dt>Duration</dt>
            <dd>152 min</dd>    
        <dt>blinkbox rating</dt>
        <dd class="stars star45">4.5 stars</dd>
    </dl>
<p class="synopsis">
    Why So Serious?
</p>
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
        <li class="purchase"><a href="http://www.blinkbox.com/Movies/28710/The-Dark-Knight">Rent -  &#163;2.49</a></li>
        <li class="save"><a class="add" title="Save for later" href="/Area/Profile/Bookmark/Add?id=28710&amp;kind=Movie"><span>Save for later</span></a></li>
    </ul>
</div>

    </li>}
      )
    }
  end
end
