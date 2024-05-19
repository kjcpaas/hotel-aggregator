# frozen_string_literal: true

require_relative './base'
require_relative '../model/image'

module Merger
  class Image < Base
    attr_reader :images

    def initialize(images)
      # Remove nils from list
      @images = images.compact

      raise 'images must have the same urls' unless same_urls?

      super(@images)
    end

    def result
      return nil if images.empty?

      @result ||= Model::Image.new(merged_data)
    end

    def merged_data
      @merged_data ||= {
        url: images[0][:url],
        caption: merge_strings(:caption)
      }
    end

    private

    def same_urls?
      return true if images.empty?

      images.map { |img| img[:url] }.uniq.length == 1
    end
  end
end
