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
