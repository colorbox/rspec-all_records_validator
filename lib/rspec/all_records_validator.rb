# frozen_string_literal: true

require_relative "all_records_validator/version"

module RSpec
  module AllRecordsValidator
    def self.validate!(ignored_models: [])
      target_classes = ApplicationRecord.subclasses.reject {|klass| klass.abstract_class? || ignored_models.include?(klass) }

      target_classes.each do |klass|
        klass.all.each do |obj|
          obj.validate!
        end
      end
    end
  end
end
