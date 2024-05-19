# frozen_string_literal: true

require_relative './base'

module Mapper
  class Paperflies < Base
    private

    def map_from_api_data
      {
        id: api_data[:hotel_id],
        destination_id: api_data[:destination_id],
        name: sanitize_string(api_data[:hotel_name]),
        description: sanitize_string(api_data[:details]),
        location: {
          address: sanitize_string(api_data.dig(:location, :address)),
          # Assume this is ISO Standard country name
          country: api_data.dig(:location, :country)
        },
        amenities: combine_amenities(api_data[:amenities]),
        booking_conditions: sanitize_booking_conditions(api_data[:booking_conditions]),
        images: {
          room: map_images(api_data.dig(:images, :rooms)),
          amenities: map_images(api_data.dig(:images, :site))
        }
      }
    end

    def combine_amenities(amenities)
      combined = amenities.inject([]) { |a, (_k, v)| a | v }
      sanitize_amenities(combined)
    end

    def map_images(images)
      return [] unless images.is_a?(Array)

      images.map do |img|
        { url: sanitize_string(img[:link]),
          caption: sanitize_string(img[:caption]) }
      end
    end
  end
end
