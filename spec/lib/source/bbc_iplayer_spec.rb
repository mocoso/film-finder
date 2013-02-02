# encoding=utf-8
require 'spec_helper'

describe Source::BBCIplayer do
  describe '#search_url' do
    specify do
      subject.search_url('doctor who').should ==
        'http://www.bbc.co.uk/iplayer/search?q=doctor+who'
    end
  end

  describe 'fragment methods' do
    describe '#rental_title' do
      it 'should extract the title from the fragment' do
        subject.rental_title(fragment).should == 'Doctor Who: Series 6: The Curse of the Black Spot'
      end
    end
    
    describe '#rental_url' do
      it 'should extract the title from the fragment' do
        subject.rental_url(fragment).should ==
          'http://www.bbc.co.uk/iplayer/episode/b0110g4b/Doctor_Who_Series_6_The_Curse_of_the_Black_Spot/'
      end
    end

    describe '#rental_image_url' do
      it 'should extract the title from the fragment' do
        subject.rental_image_url(fragment).should ==
          'http://ichef.bbci.co.uk/programmeimages/episode/b0110g4b_86_48.jpg'
      end
    end

    describe '#rental_price' do
      it 'should extract the title from the fragment' do
        subject.rental_price(fragment).should == Price.new('Free')
      end
    end

    let(:fragment) {
      Nokogiri::HTML(%q{
<div id="result-b0110g4b" class="episode-info ">
			<h3 >
									<a href="/iplayer/episode/b0110g4b/Doctor_Who_Series_6_The_Curse_of_the_Black_Spot/" title="Doctor Who: Series 6: The Curse of the Black Spot">
						<span class="episode-image cta-play">
															<span>Play this episode</span>
																				
				
							
							<img src="http://ichef.bbci.co.uk/programmeimages/episode/b0110g4b_86_48.jpg" width="86" height="48" alt="" />						</span>
						
						<span class="title">
								3. The Curse of the Black Spot						</span>
															</a>
				
											</h3>
							<p class="episode-synopsis">
					There's terror on the high seas, as the Doctor is stranded on a pirate ship.
												(<abbr title="repeat">R</abbr>)
									</p>
			
			<p class="additional">
				BBC One											</p>

					</div>}
      )
    }
  end
end
