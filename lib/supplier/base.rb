# frozen_string_literal: true

require 'json'
require 'httparty'

module Supplier
  class Base
    def name
      raise 'define the supplier name in your class'
    end

    def hotels
      response = HTTParty.get("https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/#{name}")
      JSON.parse(response.body)
    end
  end
end
