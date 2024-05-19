# frozen_string_literal: true

require_relative '../model'

module Model
  class Base
    attr_reader :data

    def initialize(data)
      @data = filter_input(data)

      validate_data!
    end

    def as_json
      data.to_json
    end

    private

    def validate_data!
      # Only validate these fields that are strictly needed to be present
      # Ideally, we need to have validations for data integrity
      # However, for simplicity, we will assume supplierrs don't supply unexpected data for those

      fields_to_validate.each do |f|
        raise ValidationError, ":#{f} must be present" unless present?(data[f])
      end
    end

    def present?(str)
      return true if str.is_a?(Integer)

      str.is_a?(String) && str.length.positive?
    end

    def filter_input(_input)
      raise NoMethodError, 'define filter_input in your model'
    end

    def fields_to_validate
      raise NoMethodError, 'define fields_to_validate in your model'
    end
  end
end
