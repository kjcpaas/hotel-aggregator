# frozen_string_literal: true

require_relative './base'

module Mapper
  class Patagonia < Base
    private

    def map_from_api_data
      {
        id: api_data[:id],
        destination_id: api_data[:destination],
        name: sanitize_string(api_data[:name]),
        description: sanitize_string(api_data[:info]),
        location: {
          latitude: sanitize_string(api_data[:lat]),
          longitude: sanitize_string(api_data[:lng]),
          address: sanitize_string(api_data[:address])
        },
        amenities: sanitize_amenities(api_data[:amenities]),
        images: {
          room: map_images(api_data.dig(:images, :rooms)),
          amenities: map_images(api_data.dig(:images, :amenities))
        }
      }
    end

    def map_images(images)
      return [] unless images.is_a?(Array)

      images.map do |img|
        { url: sanitize_string(img[:url]),
          caption: sanitize_string(img[:description]) }
      end
    end
  end
end
