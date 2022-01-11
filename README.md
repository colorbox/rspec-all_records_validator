# RSpecAllRecordvalidatorAfterSystemSpec

Check all ActiveRecord object validation after system spec.

This gem is designed for: [rspec-rails](https://github.com/rspec/rspec-rails)

## Setup

### Install 

Add this line to your application's Gemfile in test group:

```ruby
group :test do
  gem 'rspec_all_record_validator_after_system_spec'
end
```

And then execute:

    $ bundle install

### Configure

Add below to your `spec_helper.rb`

```ruby
require 'rspec_all_record_validator_after_system_spec'

RSpec.configure do |config|
  RSpecAllRecordValidattorAfterSystemSpec.judge_at_end(config)
end
```

#### Avoid validation for specific model 

You can avoid validation for specific models:

```ruby
RSpec.configure do |config|
  RSpecAllRecordValidattorAfterSystemSpec.judge_at_end(config, ignore: [DoNotValidatrThisModel])
end
```

#### For feature spec

You can config This setting for feature spec

```ruby
RSpec.configure do |config|
  RSpecAllRecordValidattorAfterSystemSpec.judge_at_end(config, type: :feature)
end
```
