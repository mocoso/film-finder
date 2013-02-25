require 'spec_helper'

describe Source::GooglePlay do
  describe '#search_url' do
    specify do
      subject.search_url('dark knight').should ==
        'https://play.google.com/store/search?c=movies&q=dark+knight'
    end
  end

  describe 'fragment methods' do
    describe '#rental_title' do
      it 'should extract the title from the fragment' do
        subject.rental_title(fragment).should == 'The Dark Knight Rises'
      end
    end
    
    describe '#rental_url' do
      it 'should extract the title from the fragment' do
        subject.rental_url(fragment).should ==
          'https://play.google.com/store/movies/details/The_Dark_Knight_Rises?id=qT3d-QcF7DA&feature=search_result'
      end
    end

    describe '#rental_image_url' do
      it 'should extract the title from the fragment' do
        subject.rental_image_url(fragment).should ==
          'https://i.ytimg.com/vi/qT3d-QcF7DA/movieposter.jpg'
      end
    end

    describe '#rental_price' do
      it 'should extract the title from the fragment' do
        subject.rental_price(fragment).should == Price.new('From £3.49')
      end
    end

    let(:fragment) {
      Nokogiri::HTML(%q{<li class="search-results-item"
data-docid="movie-qT3d-QcF7DA"><div class="snippet snippet-search"><div
class="thumbnail-wrapper goog-inline-block"><a
href="/store/movies/details/The_Dark_Knight_Rises?id=qT3d-QcF7DA&amp;feature=search_result"
class="thumbnail" data-a="2" data-c="1"><img
src="https://i.ytimg.com/vi/qT3d-QcF7DA/movieposter.jpg"alt="The Dark Knight Rises" /></a></div><div class="details goog-inline-block"><a
class="title" title="The Dark Knight Rises" data-a="1" data-c="1"
href="/store/movies/details/The_Dark_Knight_Rises?id=qT3d-QcF7DA&amp;feature=search_result">The Dark Knight Rises</a><div
class="attribution-category"></div><div><div
class="ratings-wrapper"><div class="ratings goog-inline-block"
title="Rating: 4.6 stars (Above average)"><div
class="goog-inline-block star
SPRITE_star_on_dark"></div><div class="goog-inline-block star
SPRITE_star_on_dark"></div><div class="goog-inline-block star
SPRITE_star_on_dark"></div><div class="goog-inline-block star
SPRITE_star_on_dark"></div><div class="goog-inline-block star
SPRITE_star_half_dark"></div></div><span
class="snippet-reviews">(198)</span></div></div><div
class="buy-wrapper "><div class="buy-border"><a class="buy-link
buy-button goog-inline-block" href="javascript:void(0)" data-c="3"
data-a="3"><span class="buy-button-price">From £3.49</span><span
class="buy-offer" style="display: none;"
id="bubble-movie-qT3d-QcF7DA-offer-4"data-docAttribution=""data-docConsumptionUri="/movies/watch?id=movie-qT3d-QcF7DA"
data-docId="movie-qT3d-QcF7DA" data-docTitle="The Dark Knight
Rises"data-docIconUrl="https://i.ytimg.com/vi/qT3d-QcF7DA/movieposter.jpg"
data-docType="6"
data-parentDocId=""data-docCurrencyCode="GBP" data-docPrice="£4.49"
data-docPriceMicros="4490000" data-isFree="false"
data-isPurchased="false" data-offerType="4"
data-rentalGrantPeriodDays="30"
data-rentalactivePeriodHours="48" data-offerTitle="Rent HD"
data-offerDescription="Watch in HD on supported Android devices."
data-docPubPrivacyPolicyUrl=""
data-docRequiresPSV="false"
data-docRequiresSubAddress="false"
data-docCheckedFirstPartyMarketing="false"
data-docCheckedThirdPartyMarketing="false"data-docSubIsTrial="false"></span><span
class="buy-offer default-offer" style="display: none;"
id="bubble-movie-qT3d-QcF7DA-offer-3"data-docAttribution=""data-docConsumptionUri="/movies/watch?id=movie-qT3d-QcF7DA"
data-docId="movie-qT3d-QcF7DA" data-docTitle="The Dark Knight
Rises"data-docIconUrl="https://i.ytimg.com/vi/qT3d-QcF7DA/movieposter.jpg"
data-docType="6"
data-parentDocId=""data-docCurrencyCode="GBP" data-docPrice="£3.49"
data-docPriceMicros="3490000" data-isFree="false"
data-isPurchased="false" data-offerType="3"
data-rentalGrantPeriodDays="30"
data-rentalactivePeriodHours="48" data-offerTitle="Rent SD"
data-offerDescription="Watch in standard definition on the web and
supported Android devices."
data-docPubPrivacyPolicyUrl=""
data-docRequiresPSV="false"
data-docRequiresSubAddress="false"
data-docCheckedFirstPartyMarketing="false"
data-docCheckedThirdPartyMarketing="false"data-docSubIsTrial="false"></span></a></div></div></div><div
class="description goog-inline-block">Christopher Nolan&#39;s Batman
trilogy concludes with this Warner Brothers release that finds The Dark
Knight pitted against Bane, an unstoppable foe possessed of
tremendo...</div></div></li>})
    }
  end
end
