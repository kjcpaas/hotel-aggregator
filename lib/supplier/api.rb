# frozen_string_literal: true

require 'httparty'

require_relative '../json_symbolizer'
require_relative '../model/hotel'

module Supplier
  class Api
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def find_hotel(id)
      hotels.find { |h| h.id == id }
    end

    def find_hotels_by_destination(id)
      hotels.filter do |h|
        h.destination_id == id
      end
    end

    def hotels
      # We should have error and retry handling here but for simplicity,
      # Assume supplier APIs are always up and no need to retry
      return @hotels unless @hotels.nil?

      response = HTTParty.get(config.api_url)
      hotels_from_api = JSONSymbolizer.new(response.body).symbolize

      @hotels = hotels_from_api.map do |h|
        config.mapper.new(h).to_model
      end
    end
  end
end
