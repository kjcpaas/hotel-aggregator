# frozen_string_literal: true

module Merger
  class Base
    attr_reader :data_list

    def initialize(data_list)
      @data_list = data_list
    end

    private

    def merge_strings(prop_name)
      winner = ''
      data_list.each do |dl|
        # Ignore nil
        next if dl[prop_name].nil?

        # Prioritize longer string
        if winner.nil? || dl[prop_name].length > winner.length
          winner = dl[prop_name]
        # Randomly select if same length
        elsif dl[prop_name].length == winner.length
          winner = [dl[prop_name], winner].sample
        end
      end
      winner
    end

    def merge_numbers(prop_name)
      winner = nil
      data_list.each do |dl|
        # Ignore nil
        next if dl[prop_name].nil?

        # Prioritize higher precision
        if winner.nil? || precision(dl[prop_name]) > precision(winner)
          winner = dl[prop_name]
        # Randomly select if same length
        elsif precision(dl[prop_name]) == precision(winner)
          winner = [dl[prop_name], winner].sample
        end
      end
      winner
    end

    def precision(num)
      parts = num.to_s.split('.')

      return 0 if parts.length < 2

      parts[1].length
    end

    def merge_arrays(prop_name)
      merged = []
      data_list.each do |dl|
        # Concatenate and remove dupplicates
        merged |= dl[prop_name]
      end
      merged
    end
  end
end
