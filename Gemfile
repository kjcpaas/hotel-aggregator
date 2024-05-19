# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

gem 'countries'
gem 'httparty'
gem 'sinatra', '~> 3.0.0'
gem 'thin', '>= 1.8.0'

group :development, :test do
  gem 'rubocop', require: false
end

group :test do
  gem 'rspec'
end
