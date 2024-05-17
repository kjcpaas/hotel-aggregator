# frozen_string_literal: true

require_relative '../../../lib/supplier/acme'

describe Supplier::Acme do
  let(:acme_url) { 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme' }
  let(:acme_json) do
    File.read(File.join('spec', 'fixtures', 'acme_original.json'))
  end
  let(:acme_response) { instance_double(HTTParty::Response, body: acme_json) }

  describe 'hotels' do
    it 'fetches hotels from the right API' do
      expect(HTTParty).to receive(:get).with(acme_url).and_return(acme_response)
      Supplier::Acme.new.hotels
    end
  end
end
