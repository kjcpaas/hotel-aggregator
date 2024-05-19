# frozen_string_literal: true

require 'json'

class JSONSymbolizer
  attr_reader :raw, :parsed, :symbolized

  def initialize(raw_json)
    @raw = raw_json
    @parsed = JSON.parse(raw_json)
  end

  def symbolize
    @symbolize ||= symbolize_object(parsed)
  end

  private

  def symbolize_object(obj)
    if obj.is_a?(Array)
      obj.map { |o| symbolize_object(o) }
    elsif obj.is_a?(Hash)
      obj.map { |k, v| [k.to_sym, symbolize_object(v)] }.to_h
    else
      obj
    end
  end
end
