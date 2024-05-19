# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/model/hotel'
require_relative '../../../lib/model/image'

describe Model::Hotel do
  let(:input) do
    {
      id: 'hOt3L',
      destination_id: '5uMwh3Re',
      name: 'hotel',
      description: 'Hotel somewhere out there',
      location: {
        country: 'SG',
        postal_code: '90210',
        address: '221B Baker St',
        landmark: 'Across the train station'
      },
      images: {
        room: [{
          url: 'images.com/img1',
          caption: 'the room',
          photographer: 'John Doe'
        }, {
          url: 'images.com/img2',
          caption: 'shower'
        }],
        vicinity: []
      },
      rating: '5 star'
    }
  end

  describe '#data' do
    subject do
      Model::Hotel.new(input).data
    end

    it 'has data wih full structure' do
      expect(subject).to eq(
        {
          id: 'hOt3L',
          destination_id: '5uMwh3Re',
          name: 'hotel',
          description: 'Hotel somewhere out there',
          location: {
            latitude: nil,
            longitude: nil,
            country: 'SG',
            address: '221B Baker St',
            city: nil,
            postal_code: '90210'
          },
          amenities: [],
          booking_conditions: [],
          images: {

            room: [{
              url: 'images.com/img1',
              caption: 'the room'
            }, {
              url: 'images.com/img2',
              caption: 'shower'
            }],
            amenities: []
          }
        }
      )
    end

    it 'removes unsupported data' do
      expect(subject[:rating]).to be_nil
      expect(subject.dig(:location, :landmark)).to be_nil
      expect(subject.dig(:images, :vicinity)).to be_nil
    end
  end

  describe 'validations' do
    it 'rejects when :id is not given' do
      expect do
        Model::Hotel.new(input.merge(id: ''))
      end.to raise_error(':id must be present')

      expect do
        Model::Hotel.new(input.merge(id: nil))
      end.to raise_error(':id must be present')
    end

    it 'rejects when :destination_id is not given' do
      expect do
        Model::Hotel.new(input.merge(destination_id: ''))
      end.to raise_error(':destination_id must be present')

      expect do
        Model::Hotel.new(input.merge(destination_id: nil))
      end.to raise_error(':destination_id must be present')
    end
  end
end
