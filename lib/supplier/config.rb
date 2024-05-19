# frozen_string_literal: true

module Supplier
  class Config
    attr_reader :name, :api_url, :mapper

    def initialize(name:, api_url:, mapper:)
      @name = name
      @api_url = api_url
      @mapper = mapper
    end
  end
end
