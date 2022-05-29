# frozen_string_literal: true

ENV['DB'] ||= 'sqlite3'
require 'active_record/railtie'

module RSpec::AllRecordsValidatorTestApp
  Application = Class.new(Rails::Application) do
    # Rais.root
    config.root = __dir__

    config.eager_load = false
    config.active_support.deprecation = :log

    rake_tasks do
      load 'active_record/railties/databases.rake'
    end
  end.initialize!
end

ActiveRecord::Tasks::DatabaseTasks.root ||= Rails.root
ActiveRecord::Tasks::DatabaseTasks.drop_current 'test'
ActiveRecord::Tasks::DatabaseTasks.create_current 'test'

# models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Foo < ApplicationRecord
  validates :name, length: {maximum: 10}
  has_many :foo_child
end

class FooChild < ApplicationRecord
  belongs_to :foo
end

class Bar < ApplicationRecord
  validates :name, length: {maximum: 10}
  has_many :bar_child
end

class BarChild < ApplicationRecord
  belongs_to :bar
end

class Baz < ApplicationRecord
  validates :name, length: {maximum: 10}
end

# migrations
class CreateAllTables < ActiveRecord::Migration[5.0]
  def self.up
    ActiveRecord::Base.establish_connection :test
    create_table(:foos) {|t| t.string :name; t.references :bar, foreign_key: true }
    create_table(:foo_children) {|t| t.references :foo; t.index :name, unique: true }
    create_table(:bars) {|t| t.references :foo; t.string :name; t.index :name, unique: true }
    create_table(:bar_children) {|t| t.references :bar; t.index :name, unique: true }
    create_table(:bazs) {|t| t.string :name; t.index :name, unique: true }

    ActiveRecord::Base.establish_connection :test
  end

  def self.down
    drop_table(:foos)
    drop_table(:foo_children)
    drop_table(:bars)
    drop_table(:bar_children)
    drop_table(:bazs)

    ActiveRecord::Base.establish_connection :test
  end
end
