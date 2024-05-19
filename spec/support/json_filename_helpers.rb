# frozen_string_literal: true

require 'json'

module JSONFilenameHelpers
  def hotel_from_api(supplier, id)
    File.join('hotels', 'from_api', supplier, "#{id}.json")
  end

  def hotel_mapped(supplier, id)
    File.join('hotels', 'mapped', supplier, "#{id}.json")
  end
end
