# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/supplier/api'
require_relative '../../../lib/supplier/configs'
require_relative '../../../lib/model/hotel'

describe Supplier::Api do
  shared_context 'queries working for supplier' do
    let(:api_json) { raw_json(supplier_response(name)) }
    let(:api_response) { instance_double(HTTParty::Response, body: api_json) }

    before do
      allow(HTTParty).to receive(:get).with(config.api_url).and_return(api_response)
    end

    subject { Supplier::Api.new(config) }

    describe '#hotels' do
      it 'fetches hotels from the right API' do
        expect(HTTParty).to receive(:get).with(config.api_url).and_return(api_response)
        subject.hotels
      end

      it 'returns an array of standardized hotel models' do
        expect(subject.hotels).to be_a(Array)
        subject.hotels.each do |h|
          expect(h).to be_a(Model::Hotel)
        end
      end
    end

    describe 'find_hotel_by_id' do
      it 'returns nil when hotel does not exist' do
        expect(subject.find_hotel('idontexist')).to be nil
      end

      it 'returns Hotel model with standardized hotel data' do
        id = 'iJhz'
        expected_data = parsed_json hotel_mapped(name, id)

        hotel = subject.find_hotel(id)
        expect(hotel&.data).to eq expected_data
      end
    end

    describe 'find_hotels_by_destination' do
      it 'returns empty array when no hotels exist in destination' do
        expect(subject.find_hotels_by_destination(0o0000)).to eq []
      end

      it 'returns hotels that are all in the destination' do
        destination_id = 5432

        hotels = subject.find_hotels_by_destination(destination_id)

        expect(hotels).to_not be_empty
        expect(hotels.map(&:destination_id).uniq).to eq [destination_id]
      end
    end
  end

  context 'acme' do
    let(:config) { Supplier::Configs::Acme }
    let(:name) { 'acme' }

    it_behaves_like 'queries working for supplier'
  end

  context 'paperflies' do
    let(:config) { Supplier::Configs::Paperflies }
    let(:name) { 'paperflies' }

    it_behaves_like 'queries working for supplier'
  end

  context 'patagonia' do
    let(:config) { Supplier::Configs::Patagonia }
    let(:name) { 'patagonia' }

    it_behaves_like 'queries working for supplier'
  end
end
