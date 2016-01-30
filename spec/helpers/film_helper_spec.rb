require 'spec_helper'

describe FilmHelper do
  include FilmHelper

  describe '#film_meta_data' do
    let(:release_year) { nil }
    let(:certificate) { nil }
    let(:type) { nil }
    let(:length_in_minutes) { nil }
    let(:film) { double('film', :release_year => release_year, :certificate => certificate, :type => type, :length_in_minutes => length_in_minutes) }

    context 'without year or certificate' do
      it { expect(film_meta_data(film)).to eq([]) }
    end

    context 'with year' do
      let(:release_year) { '1978' }

      it { expect(film_meta_data(film)).to eq(['1978']) }
    end

    context 'with certificate' do
      let(:certificate) { 'U' }

      it { expect(film_meta_data(film)).to eq(['Cert: U']) }
    end

    context 'with year and certificate' do
      let(:release_year) { '1978' }
      let(:certificate) { 'U' }

      it { expect(film_meta_data(film)).to eq(['1978', 'Cert: U']) }
    end

    context 'with certificate and length' do
      let(:certificate) { 'U' }
      let(:length_in_minutes) { '91' }

      it { expect(film_meta_data(film)).to eq(['Cert: U', '91 mins']) }
    end

    context 'wtih TV episode' do
      let(:type) { Rental::TV_EPISODE_TYPE }

      it { expect(film_meta_data(film)).to eq(['TV Episode']) }
    end
  end
end

