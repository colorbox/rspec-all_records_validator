# frozen_string_literal: true

require_relative "anubis/version"

module Anubis
  def self.judge_at_end(config, ignore_models: [])
    config.after type: :feature do
      ApplicationRecord.subclasses.reject {|klass| klass.abstract_class }.all? {|klass|
        next if ignore_models.include? klass

        klass.all.each {|obj|
          expect(obj).to be_valid
        }
      }
    end
  end
end
