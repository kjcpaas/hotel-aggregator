# frozen_string_literal: true

require_relative '../supplier/api'
require_relative '../supplier/configs'
require_relative '../merger/hotel'

module Query
  class FindHotel
    attr_accessor :id, :result

    def initialize(id)
      @id = id
    end

    # NOTES: performance
    #
    # We cache at this point as it is the "cleanest" form of our data.
    #
    # This method with check against the Redis cache for availability
    # of processed hotel data in the cache.
    #
    # If not, query will be performed against the supplier apis and merged.
    #
    # The merged data will be stored to Redis via a background worker,
    # to not block the response to the user
    def perform
      hotels = apis.map { |a| a.find_hotel(id) }
      merger = Merger::Hotel.new(hotels)
      merger.result
    end

    private

    def apis
      @apis ||= Supplier::Configs::LIST.map do |config|
        Supplier::Api.new(config)
      end
    end
  end
end
