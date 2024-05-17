# frozen_string_literal: true

require 'sinatra'

get '/' do
  content_type :json # Set Content-Type to JSON

  { message: 'hello' }.to_json
end
