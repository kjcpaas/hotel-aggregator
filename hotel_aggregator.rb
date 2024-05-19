# frozen_string_literal: true

require_relative './lib/query/find_hotel'
require_relative './lib/query/find_hotels_by_destination'

require 'sinatra'

before do
  content_type :json # Set Content-Type to JSON
end

get '/' do
  { message: 'Go to /hotels for the API | ' \
    'no query = will return a full list of hotels |' \
    'You can pass queries as /hotels?id=id&destination_id=destination_id' }
end

get '/hotels' do
  if !params[:id].nil? && !params[:destination_id].nil?
    status 400
    return { message: 'Select only one of :id or :destination_id' }.to_json
  end

  unless params[:id].nil?
    hotel = Query::FindHotel.new(params[:id]).perform

    if hotel.nil?
      status 404
      return { message: 'Cannot find hotel with that id' }.to_json
    end

    return hotel.as_json
  end

  hotels = Query::FindHotelsByDestination.new(params[:destination_id]).perform
  hotels.map(&:data).to_json
end
