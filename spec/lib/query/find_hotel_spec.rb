# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/query/find_hotel'
require_relative '../../../lib/supplier/configs'

describe Query::FindHotel do
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

  context 'hotel not found all suppliers' do
    let(:id) { 'nonexistent' }

    it 'returns nil' do
      hotel = Query::FindHotel.new(id).perform

      expect(hotel).to be_nil
    end
  end

  context 'hotel exists in all suppliers' do
    let(:id) { 'iJhz' }
    let(:merged_json) { parsed_json(hotel_merged(id)) }

    it 'prioritizes the more complete data in the merge' do
      hotel = Query::FindHotel.new(id).perform

      expect(hotel.data).to eq merged_json
    end
  end

  context 'hotel exists in a subset of suppliers' do
    let(:id) { 'SjyX' } # Not in Patagonia
    let(:merged_json) { parsed_json(hotel_merged(id)) }

    it 'exists' do
      hotel = Query::FindHotel.new(id).perform
      expect(hotel).to_not be_nil
    end

    it 'prioritizes the more complete data in the merge' do
      hotel = Query::FindHotel.new(id).perform

      expect(hotel.data).to eq merged_json
    end
  end
end
