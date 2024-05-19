# frozen_string_literal: true

require_relative '../supplier/api'
require_relative '../supplier/configs'
require_relative '../merger/hotel'
require_relative '../merger/object_array'

module Query
  class FindHotelsByDestination
    attr_accessor :destination_id, :result

    def initialize(destination_id)
      @destination_id = destination_id
    end

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
