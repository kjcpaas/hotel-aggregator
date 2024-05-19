# frozen_string_literal: true

require_relative './base'

module Model
  class Image < Base
    EMPTY_DATA = {
      url: nil,
      caption: nil
    }.freeze

    def url
      data[:url]
    end

    def caption
      data[:caption]
    end

    private

    def fields_to_validate
      # require url as it is needed to render image in the frontend
      [:url]
    end

    # Only select relevant image fields
    def filter_input(input)
      filtered = input.slice(:url, :caption)
      EMPTY_DATA.merge(filtered)
    end
  end
end
