# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/json_symbolizer'

describe JSONSymbolizer do
  it 'restores array to Ruby object' do
    obj = [
      { a: 'b', c: { d: 'e', f: %w[foo bar] } },
      { a: 'c', c: { c: 'e', x: %w[boo far] } }
    ]
    json = obj.to_json

    expect(JSONSymbolizer.new(json).symbolize).to eq obj
  end

  it 'restores hash to symbolized Ruby hash' do
    obj = {
      a: [1, 4, 5, 6],
      b: { az: 'boo', fx: 'car' },
      c: 'something'
    }
    json = obj.to_json

    expect(JSONSymbolizer.new(json).symbolize).to eq obj
  end

  it 'restores simple objects to Ruby object' do
    expect(JSONSymbolizer.new('string'.to_json).symbolize).to eq 'string'
    expect(JSONSymbolizer.new(2.to_json).symbolize).to eq 2
  end
end
