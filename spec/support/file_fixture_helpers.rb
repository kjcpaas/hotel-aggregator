# frozen_string_literal: true

require_relative '../../lib/json_symbolizer'

module FileFixtureHelpers
  # Use in conjunction withe JsonFileNameHelpers
  def raw_json(filename)
    File.read(File.join('spec', 'fixtures', filename))
  end

  def parsed_json(filename)
    JSONSymbolizer.new(raw_json(filename)).symbolize
  end
end
