# frozen_string_literal: true

require_relative "rspec_all_record_validator_after_system_spec/version"

module RSpecAllRecordvalidatorAfterSystemSpec
  def self.judge_at_end(config, ignore_models: [], type: :system)
    config.after type: type do
      ApplicationRecord.subclasses.reject {|klass| klass.abstract_class }.all? {|klass|
        next if ignore_models.include? klass

        klass.all.each {|obj|
          expect(obj).to be_valid
        }
      }
    end
  end
end
