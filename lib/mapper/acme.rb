# frozen_string_literal: true

require 'countries/global'

require_relative './base'

module Mapper
  class Acme < Base
    private

    def map_from_api_data
      {
        id: api_data[:Id],
        destination_id: api_data[:DestinationId],
        name: sanitize_string(api_data[:Name]),
        description: sanitize_string(api_data[:Description]),
        location: {
          latitude: sanitize_string(api_data[:Latitude]),
          longitude: sanitize_string(api_data[:Longitude]),
          address: sanitize_string(api_data[:Address]),
          city: sanitize_string(api_data[:City]),
          # Assume this is using ISO standard alpha2 code
          country: to_full_country(sanitize_string(api_data[:Country])),
          postal_code: sanitize_string(api_data[:PostalCode])
        },
        amenities: sanitize_amenities(api_data[:Facilities])
      }
    end

    def to_full_country(alpha2_code)
      Country[alpha2_code.upcase]&.iso_short_name
    end
  end
end
