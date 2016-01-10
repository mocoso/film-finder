require 'spec_helper'

describe FilmHelper do
  include FilmHelper

  describe '#film_meta_data' do
    let(:year) { nil }
    let(:certificate) { nil }
    let(:type) { nil }
    let(:film) { double('film', :year => year, :certificate => certificate, :type => type) }

    context 'without year or certificate' do
      it { expect(film_meta_data(film)).to eq([]) }
    end

    context 'with year' do
      let(:year) { '1978' }

      it { expect(film_meta_data(film)).to eq(['1978']) }
    end

    context 'with certificate' do
      let(:certificate) { 'U' }

      it { expect(film_meta_data(film)).to eq(['Cert: U']) }
    end

    context 'with year and certificate' do
      let(:year) { '1978' }
      let(:certificate) { 'U' }

      it { expect(film_meta_data(film)).to eq(['1978', 'Cert: U']) }
    end

    context 'wtih TV episode' do
      let(:type) { Rental::TV_EPISODE_TYPE }

      it { expect(film_meta_data(film)).to eq(['TV Episode']) }
    end
  end
end

