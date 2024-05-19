# frozen_string_literal: true

require_relative './base'

module Merger
  class Location < Base
    attr_reader :locations

    def initialize(locations)
      # Remove nils from list
      @locations = locations.compact
      super(@locations)
    end

    def result
      return nil if locations.empty?

      @result ||= merged_data
    end

    def merged_data
      @merged_data ||= {
        latitude: merge_numbers(:latitude),
        longitude: merge_numbers(:longitude),
        address: merge_strings(:address),
        city: merge_strings(:city),
        country: merge_strings(:country),
        postal_code: merge_strings(:postal_code)
      }
    end
  end
end
