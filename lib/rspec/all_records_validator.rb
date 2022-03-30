# frozen_string_literal: true

require_relative "all_records_validator/version"

module RSpec
  module AllRecordsValidator
    def self.validate_all_objects(ignore_models: [])
      target_classes = ApplicationRecord.subclasses.reject {|klass| klass.abstract_class? || ignore_models.include?(klass) }

      target_classes.each do |klass|
        klass.all.each do |obj|
          yield(obj)
        end
      end
    end
  end
end
