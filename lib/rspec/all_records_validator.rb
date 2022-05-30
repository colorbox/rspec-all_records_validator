# frozen_string_literal: true

require_relative "all_records_validator/version"

module RSpec
  module AllRecordsValidator
    def self.validate!(ignored_models: [], only_has_many: false)
      target_classes = ApplicationRecord.subclasses.reject {|klass| klass.abstract_class? || ignored_models.include?(klass) || (only_has_many && klass.reflect_on_all_associations(:has_many).blank?) }

      target_classes.each do |klass|
        klass.all.each do |obj|
          obj.validate!
        end
      end
    end
  end
end
