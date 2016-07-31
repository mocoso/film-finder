# utf-8
require 'spec_helper'

describe Rental do
  describe '#<=>' do
    let(:no_priced) { Rental.new({}) }
    let(:high_priced) { Rental.new :prices => [Price.new('£5.99')] }
    let(:low_priced) { Rental.new :prices => [Price.new('£0.99'), Price.new('£9.99')] }

    specify { expect(no_priced <=> high_priced).to eq 1 }
    specify { expect(high_priced <=> low_priced).to eq 1 }
    specify { expect(low_priced <=> high_priced).to eq(-1) }
    specify { expect(high_priced <=> no_priced).to eq(-1) }
  end

  describe '#match_film?' do
    subject(:rental) { Rental.new(:title => Title.new('Inception'), :release_year => release_year) }

    let(:film_with_same_title) { double('Inception film', :title => Title.new('Inception'), :release_year => nil) }
    let(:film_with_different_title) { double('Hangover film', :title => Title.new('The Hangover'), :release_year => nil) }
    let(:film_with_same_title_and_year) { double('Inception film with year', :title => Title.new('Inception'), :release_year => '2010') }

    context 'no year' do
      let(:release_year) { nil }
      it { expect(subject.match_film?(film_with_same_title)).to be_truthy }
      it { expect(subject.match_film?(film_with_same_title_and_year)).to be_truthy }
      it { expect(subject.match_film?(film_with_different_title)).to be_falsey }
    end

    context 'with year' do
      let(:release_year) { '2010' }
      let(:film_with_same_title_and_different_year) { double('Inception film with different year', :title => Title.new('Inception'), :release_year => '1972') }
      let(:film_with_same_title_and_similar_year) { double('Inception film with similar year', :title => Title.new('Inception'), :release_year => '2011') }

      it { expect(subject.match_film?(film_with_same_title)).to be_truthy }
      it { expect(subject.match_film?(film_with_same_title_and_year)).to be_truthy }
      it { expect(subject.match_film?(film_with_same_title_and_similar_year)).to be_truthy }
      it { expect(subject.match_film?(film_with_same_title_and_different_year)).to be_falsey }
      it { expect(subject.match_film?(film_with_different_title)).to be_falsey }
    end
  end
end

