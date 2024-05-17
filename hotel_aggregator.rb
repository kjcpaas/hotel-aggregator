# frozen_string_literal: true

require 'sinatra'

require_relative 'lib/supplier/acme'

before do
  content_type :json # Set Content-Type to JSON
end

get '/' do
  { message: 'hello' }.to_json
end

get '/hotels' do
  Supplier::Acme.new.hotels.to_json
end
