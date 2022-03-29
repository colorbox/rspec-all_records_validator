# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'rails'
require 'rspec/all_record_validator'
require 'active_record'
require 'fake_app'

migrated = ActiveRecord::Base.connection.data_source_exists?('foos')
CreateAllTables.up unless migrated
