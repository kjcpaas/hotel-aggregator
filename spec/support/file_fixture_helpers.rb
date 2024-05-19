# frozen_string_literal: true

require 'json'

module FileFixtureHelpers
  # Use in conjunction withe JsonFileNameHelpers
  def raw_json(filename)
    File.read(File.join('spec', 'fixtures', filename))
  end

  def parsed_json(filename)
    json = JSON.parse(raw_json(filename))
    symbolize_json(json)
  end

  private

  def symbolize_json(obj)
    if obj.is_a?(Array)
      obj.map { |o| symbolize_json(o) }
    elsif obj.is_a?(Hash)
      obj.map { |k, v| [k.to_sym, symbolize_json(v)] }.to_h
    else
      obj
    end
  end
end
