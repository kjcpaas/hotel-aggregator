# frozen_string_literal: true

require_relative './base'
require_relative './location'
require_relative '../model/hotel'

module Merger
  class Hotel < Base
    attr_reader :hotels

    def initialize(hotels)
      # Remove nils from list
      @hotels = hotels.compact

      raise 'hotels must have the same ids' unless same_ids?

      super(@hotels.map(&:data))
    end

    def result
      return nil if hotels.empty?

      @result ||= Model::Hotel.new(merged_data)
    end

    def merged_data
      @merged_data ||= {
        # Assume id and destination_id are consistent for all sources
        id: hotels[0].id,
        destination_id: hotels[0].destination_id,
        name: merge_strings(:name),
        description: merge_strings(:description),
        location: merge_locations,
        amenities: merge_arrays(:amenities),
        booking_conditions: merge_arrays(:booking_conditions),
        # TODO: WILL be handled when we combine hotel arrays as it's same strategy
        images: {
          rooms: [],
          amenities: []
        }
      }
    end

    private

    def same_ids?
      return true if hotels.empty?

      hotels.map(&:id).uniq.length == 1
    end

    def merge_locations
      locations = data_list.map { |dl| dl[:location] }
      Merger::Location.new(locations).result
    end
  end
end
