# frozen_string_literal: true

require_relative './base'
require_relative './image'

module Model
  class Hotel < Base
    EMPTY_DATA = {
      id: nil,
      destination_id: nil,
      name: nil,
      description: nil,
      location: {},
      amenities: [],
      booking_conditions: [],
      images: {}
    }.freeze

    EMPTY_LOCATION = {
      latitude: nil,
      longitude: nil,
      country: nil,
      address: nil,
      city: nil,
      postal_code: nil
    }.freeze

    EMPTY_IMAGES = {
      room: [],
      amenities: []
    }.freeze

    def id
      data[:id]
    end

    def destination_id
      data[:destination_id]
    end

    private

    def fields_to_validate
      # require these fields to be present as they are needed for reqcord filtering
      %i[id destination_id]
    end

    # Only select relevant hotel data
    def filter_input(input)
      filtered = input.slice(
        :id, :destination_id, :name, :description,
        :location, :amenities, :booking_conditions, :images
      )
      combined = EMPTY_DATA.merge(filtered)

      combined.merge(
        location: filter_location(combined[:location]),
        images: filter_images(combined[:images])
      )
    end

    def filter_location(loc)
      filtered = loc.slice(
        :latitude, :longitude,
        :country, :city,
        :address, :postal_code
      )

      EMPTY_LOCATION.merge(filtered)
    end

    def filter_images(imgs)
      filtered = imgs.slice(:room, :amenities)
      combined = EMPTY_IMAGES.merge(filtered)

      standardize_images(combined)
    end

    def standardize_images(imgs)
      standardized = {}

      imgs.each do |category, arr|
        standardized[category] = arr.map do |img|
          Image.new(img).data
        end
      end

      standardized
    end
  end
end
