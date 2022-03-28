# frozen_string_literal: true

require_relative "rspec_all_record_validator/version"

module RSpecAllRecordValidator
  def self.validate_all_objects(ignore_models: [])
    target_classes = ApplicationRecord.subclasses.reject {|klass| klass.abstract_class? || ignore_models.include?(klass) }

    target_classes.each do |klass|
      klass.all.each do |obj|
        yield(obj)
      end
    end
  end
end
