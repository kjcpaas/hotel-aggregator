# frozen_string_literal: true

require_relative '../supplier/api'
require_relative '../supplier/configs'
require_relative '../merger/hotel'
require_relative '../merger/object_array'

module Query
  class FindHotelsByDestination
    attr_accessor :destination_id, :result

    def initialize(destination_id = nil)
      @destination_id = destination_id
    end

    # NOTES: performance
    #
    # We cache at this point as it is the "cleanest" form of our data.
    #
    # We can use Redis to save the result of this query, with a ttl that
    # we consider the data to be valid, e.g. 10mins, 30min, 1hr, etc.
    #
    # This depends on business/product specifications and also technical consideration
    # around storage costs, complexity,  etc
    #
    # Data structure
    # - list: { destination_id, hotels }
    #   - We can also save just the array of hotel ids but that will require extra processing
    #     to collect the individual hotel data from the cache (which may not be worth the benefit)
    #   - However, if storage costs is not a big concern, we can save the full hotel list data,
    #     and this is the simpler approach.
    #
    # - hotel: each hotel in the list will be saved with the full hotel data
    #   - This can be used by FindHotelQuery as well
    #
    # Hence, at the start of perform, it will check Redis for the availability of hotel list.
    #
    # If not available, then it will run the code below.
    # So as not to block the response to the user waiting in the browser,
    # we will delegate to a worker the Redis caching of the data
    def perform
      hotels = apis.map { |a| a.find_hotels_by_destination(destination_id) }
      merger = Merger::ObjectArray.new(hotels, Merger::Hotel, &:id)
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
