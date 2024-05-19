# frozen_string_literal: true

require 'json'

module JSONFilenameHelpers
  def hotel_from_api(supplier, id)
    File.join('hotels', 'from_api', supplier, "#{id}.json")
  end

  def hotel_mapped(supplier, id)
    File.join('hotels', 'mapped', supplier, "#{id}.json")
  end

  def hotel_merged(id)
    File.join('hotels', 'merged', "#{id}.json")
  end

  def supplier_response(supplier)
    File.join('supplier_responses', "#{supplier}.json")
  end
end
