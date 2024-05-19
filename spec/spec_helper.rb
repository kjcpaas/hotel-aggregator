# frozen_string_literal: true

require_relative 'support/json_filename_helpers'
require_relative 'support/file_fixture_helpers'

RSpec.configure do |c|
  c.include JSONFilenameHelpers
  c.include FileFixtureHelpers
end
