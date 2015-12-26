require 'spec_helper'

describe RentalQuery do
  describe 'error?' do
    let(:query) { double(:query) }
    let(:search_url) { double(:search_url) }
    let(:source) { double(:source, :search_url => search_url) }
    let(:success) { true }
    let(:t_response) { double(:response, :success? => success) }
    let(:t_request) { double(:request, :response => t_response) }

    before(:each) {
      Typhoeus::Request.stub(:new => t_request)
    }

    subject { RentalQuery.new(query, source) }
    context 'success response from source' do
      it { subject.error?.should be_falsey }
    end
    context 'without success response from source' do
      let(:success) { false }
      it { subject.error?.should be_truthy }
    end
  end
end

