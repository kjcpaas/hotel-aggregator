# frozen_string_literal: true

module Mapper
  class Base
    attr_reader :api_data, :model

    def initialize(api_data)
      @api_data = api_data
    end

    # Maps raw
    def to_model
      @to_model ||= Model::Hotel.new(
        map_from_api_data
      )
    end

    private

    def map_from_api_data
      raise NoMethodError, 'define map_from_api_data in inheriting class'
    end

    def sanitize_string(str)
      return str unless str.is_a?(String)

      # Remove leading and trailing spaces
      str.strip
    end

    # Categories will be removed from amenities as some suppliers
    # only have single-array amenities.
    #
    # It will be difficult to categorize each amenity unless
    # we have a mapping of a full amenity list to each category
    #
    # Individual amenities will be in PascalCase format as it is the easiest to standardize.
    # It is harder to generate accurate words from PascalCase.
    # For example WiFi will be 'wi fi' which is wrong
    # We cannot deduce the word separator when generating from PascalCase.
    def sanitize_amenities(amenity_list)
      return [] unless amenity_list.is_a?(Array)

      amenity_list.map do |a|
        sanitize_string(a).split(' ').map { |word| word[0] == word[0].upcase ? word : word.capitalize }.join
      end
    end

    def sanitize_booking_conditions(booking_conditions)
      return [] unless booking_conditions.is_a?(Array)

      booking_conditions.map do |bc|
        sanitize_string(bc)
      end
    end
  end
end
