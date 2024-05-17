# frozen_string_literal: true

require_relative '../../../lib/supplier/patagonia'

describe Supplier::Patagonia do
  let(:patagonia_url) { 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia' }
  let(:patagonia_json) do
    File.read(File.join('spec', 'fixtures', 'patagonia_original.json'))
  end
  let(:patagonia_response) { instance_double(HTTParty::Response, body: patagonia_json) }

  describe 'hotels' do
    it 'fetches hotels from the right API' do
      expect(HTTParty).to receive(:get).with(patagonia_url).and_return(patagonia_response)
      Supplier::Patagonia.new.hotels
    end
  end
end
