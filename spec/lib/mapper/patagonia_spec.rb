# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/mapper/patagonia'
require_relative '../../../lib/model/hotel'

describe Mapper::Patagonia do
  let(:api_data) { parsed_json hotel_from_api('patagonia', 'iJhz') }

  describe '#to_model' do
    subject do
      Mapper::Patagonia.new(api_data).to_model
    end

    it 'returns a standard Hotel model' do
      expect(subject).to be_a Model::Hotel
    end
  end

  describe 'model data' do
    let(:mapped_data) { parsed_json hotel_mapped('patagonia', 'iJhz') }

    subject do
      Mapper::Patagonia.new(api_data).to_model.data
    end

    it 'has data mapped to the standard hotel structure' do
      expect(subject).to eq mapped_data
    end
  end
end
