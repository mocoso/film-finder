require 'spec_helper'

describe Source::Film4oD do
  describe '#search_url' do
    specify do
      subject.search_url('dark knight').should ==
        'http://film4od.film4.com/Search/?searchQuery=dark+knight'
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
          'http://film4od.film4.com/Films/D/The-Dark-Knight-Rises/'
      end
    end

    describe '#rental_image_url' do
      it 'should extract the title from the fragment' do
        subject.rental_image_url(fragment).should ==
          'http://content.film4od.com/Images/2012/11/29/portrait130x184/FF-00002660-IM-01portrait130x184.png'
      end
    end

    describe '#rental_price' do
      it 'should extract the title from the fragment' do
        subject.rental_price(fragment).should == Price.new('£3.99')
      end
    end

    let(:fragment) {
      Nokogiri::HTML(%q{
<li class="film filmResult pageStyleA">
                <hr />
                <h3 class="unstyled"><a name='filmref:EP-00002660-01:11787' href="/Films/D/The-Dark-Knight-Rises/">The <span class='searchHit'>Dark Knight</span> Rises</a></h3>
                <!--[if ! lte IE 6]><!--><div class="hoverable"><!--<![endif]-->
                <!--[if lte IE 6]><div class="hoverable timeHover" id="ctl00_Content_ContentFull_ContentLeft_FilmPagedRepeater" begin="ctl00_Content_ContentFull_ContentLeft_FilmPagedRepeater.mouseenter" end="ctl00_Content_ContentFull_ContentLeft_FilmPagedRepeater.mouseleave" timeaction="class:hover"><![endif]-->
                    <a href="/Films/D/The-Dark-Knight-Rises/" title="The Dark Knight Rises"><img src="http://content.film4od.com/Images/2012/11/29/portrait130x184/FF-00002660-IM-01portrait130x184.png" alt="Packshot for the film The Dark Knight Rises" /></a>
                    <ul>
                        <li class="watchTrailer"><a class="openTrailer" href="/Common/pages/trailerplayer.aspx?source=SearchPage&amp;pageId=5933&amp;startPlaylistId=1&amp;startFilmId=EP-00002660-01;11787" title="Watch Trailer">Watch Trailer</a></li>
                    </ul>
                </div>
                <div class="filmControls ">
                    <strong>£3.99</strong>
                    <div><a class="iconButtonA addToBasket" href="/Basket.Handler?action=add&amp;supplierReference=EP-00002660-01&amp;offerId=11787" title="Add to Basket">Basket</a></div>
                    <div><a class="iconButtonA watchNow" href="/Basket.Handler?action=add&amp;supplierReference=EP-00002660-01&amp;offerId=11787" title="Watch Now">Watch Now</a></div>
                </div>

                <dl class="rentalCertLengthDate">
                  <dt>Certificate</dt>
                  <dd class="filmCertification cert12">12 Certificate</dd>
                  <dt>Title</dt>
                  <dd>157 mins</dd>
                  <dt>Released</dt>
                  <dd class="filmReleaseYear">2012</dd>
                </dl>
                
	            <p class="smalltext">Directed by Christopher Nolan. Gotham City's crime fighting vigilante Batman (Christian Bale) disappeared after the death of Harvey Dent. But a new villain known as Bane (Tom Hardy) has emerged and the city desperately needs a hero. Batman must come out of retirement and stop Bane from destroying the city. With Gary Oldman, Morgan Freeman, Michael Caine, Joseph Gordon-Levitt, Anne Hathaway and Marion Cotillard. Moderate fantasy violence and one scene of a sexual nature.</p>
	            <ul class="smalltext talents">
	                
        <li class='directors'>
        <h4 class="unstyled">Director</h4>
        <ul>
    
        <li>Christopher Nolan</li>     
    
        </ul>
        </li>
    
 
	                
        <li class='screenwriters'>
        <h4 class="unstyled">Screen writer</h4>
        <ul>
    
        <li>Jonathan Nolan</li>     
    
        <li>Christopher Nolan</li>     
    
        </ul>
        </li>
    
 
	                
        <li class='cast'>
        <h4 class="unstyled">Cast</h4>
        <ul>
    
        <li><a href='/Talents/B/Christian-Bale/'>Christian Bale</a></li>     
    
        <li><a href='/Talents/C/Michael-Caine/'>Michael Caine</a></li>     
    
        <li><a href='/Talents/O/Gary-Oldman/'>Gary Oldman</a></li>     
    
        <li><a href='/Talents/H/Anne-Hathaway/'>Anne Hathaway</a></li>     
    
        <li><a href='/Talents/H/Tom-Hardy/'>Tom Hardy</a></li>     
    
        <li><a href='/Talents/C/Marion-Cotillard/'>Marion Cotillard</a></li>     
    
        <li><a href='/Talents/G/Joseph-Gordon-Levitt/'>Joseph Gordon-Levitt</a></li>     
    
        <li><a href='/Talents/F/Morgan-Freeman/'>Morgan Freeman</a></li>     
    
        <li>Matthew Modine</li>     
    
        <li>Ben Mendelsohn</li>     
    
        <li>Juno Temple</li>     
    
        <li>Tom Conti</li>     
    
        </ul>
        </li>
    
 
                </ul>
            </li>})
    }
  end
end
