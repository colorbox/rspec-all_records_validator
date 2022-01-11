# frozen_string_literal: true

require_relative "rspec_all_record_validator_after_system_spec/version"

module RSpecAllRecordvalidatorAfterSystemSpec
  def self.judge_at_end(config, ignore_models: [], type: :system)
    config.after type: type do
      target_classes = ApplicationRecord.subclasses.reject {|klass| klass.abstract_class? || ignore_models.include?(klass) }

      target_classes.each do |klass|
        klass.all.each do |obj|
          expect(obj).to be_valid
        end
      end
    end
  end
end
