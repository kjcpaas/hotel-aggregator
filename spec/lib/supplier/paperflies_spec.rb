# frozen_string_literal: true

require_relative '../../../lib/supplier/paperflies'

describe Supplier::Paperflies do
  let(:paperflies_url) { 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies' }
  let(:paperflies_json) do
    File.read(File.join('spec', 'fixtures', 'paperflies_original.json'))
  end
  let(:paperflies_response) { instance_double(HTTParty::Response, body: paperflies_json) }

  describe 'hotels' do
    it 'fetches hotels from the right API' do
      expect(HTTParty).to receive(:get).with(paperflies_url).and_return(paperflies_response)
      Supplier::Paperflies.new.hotels
    end
  end
end
