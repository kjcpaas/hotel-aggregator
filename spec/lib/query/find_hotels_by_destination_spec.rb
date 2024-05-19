# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/query/find_hotels_by_destination'
require_relative '../../../lib/supplier/configs'

describe Query::FindHotelsByDestination do
  let(:acme_json) { raw_json(supplier_response('acme')) }
  let(:acme_response) { instance_double(HTTParty::Response, body: acme_json) }
  let(:paperflies_json) { raw_json(supplier_response('paperflies')) }
  let(:paperflies_response) { instance_double(HTTParty::Response, body: paperflies_json) }
  let(:patagonia_json) { raw_json(supplier_response('patagonia')) }
  let(:patagonia_response) { instance_double(HTTParty::Response, body: patagonia_json) }

  before do
    allow(HTTParty).to receive(:get).with(Supplier::Configs::Acme.api_url).and_return(acme_response)
    allow(HTTParty).to receive(:get).with(Supplier::Configs::Paperflies.api_url).and_return(paperflies_response)
    allow(HTTParty).to receive(:get).with(Supplier::Configs::Patagonia.api_url).and_return(patagonia_response)
  end

  context 'not hotel in destination from all suppliers' do
    let(:destination_id) { 0o00000 }

    it 'returns empty array' do
      hotel = Query::FindHotelsByDestination.new(destination_id).perform

      expect(hotel).to eq []
    end
  end

  context 'destination has hotels' do
    let(:destination_id) { 5432 }
    let(:merged_json) { parsed_json(destination_merged(destination_id)) }

    it 'shows combined data from suppliers' do
      hotels = Query::FindHotelsByDestination.new(destination_id).perform

      expect(hotels.map(&:data)).to eq merged_json
    end
  end
end
