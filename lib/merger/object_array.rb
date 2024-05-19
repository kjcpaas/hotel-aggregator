# frozen_string_literal: true

require_relative './base'

module Merger
  # Used for merging complex objects
  class ObjectArray
    attr_reader :arrays, :grouping, :merger_class

    def initialize(arrays, merger_class, &grouping)
      # Remove nils from list
      @arrays = arrays.compact
      # What property is used to determine if 2 hashes are the same
      @grouping = grouping
      # What merger class to use for merging the elements
      @merger_class = merger_class
    end

    def result
      return @result unless @result.nil?

      grouped_hashes.map do |_k, v|
        merger_class.new(v).result
      end
    end

    private

    def concatenated_array
      @concatenated_array ||= arrays.inject([]) do |collection, a|
        collection | a
      end
    end

    def grouped_hashes
      @grouped_hashes ||= concatenated_array.group_by do |o|
        grouping.call(o)
      end
    end
  end
end
