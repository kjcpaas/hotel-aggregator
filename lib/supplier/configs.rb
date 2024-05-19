# frozen_string_literal: true

require_relative './config'
require_relative '../mapper/acme'
require_relative '../mapper/paperflies'
require_relative '../mapper/patagonia'

module Supplier
  module Configs
    Acme = Config.new(
      name: 'acme',
      api_url: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme',
      mapper: Mapper::Acme
    )

    Paperflies = Config.new(
      name: 'paperflies',
      api_url: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies',
      mapper: Mapper::Paperflies
    )

    Patagonia = Config.new(
      name: 'patagonia',
      api_url: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia',
      mapper: Mapper::Patagonia
    )
  end
end
