# RSpec::AllRecordValidator

Check all ActiveRecord object validation after system spec.

This gem is designed for: [rspec-rails](https://github.com/rspec/rspec-rails)

## Setup

### Install 

Add this line to your application's Gemfile in test group:

```ruby
group :test do
  gem 'rspec-all_record_validator'
end
```

And then execute:

```
$ bundle install
```

### Configure

Add below to your `spec_helper.rb`

```ruby
require 'rspec/all_record_validator'

RSpec.configure do |config|
  config.after type: :system do
    RSpec::AllRecordValidator.validate_all_objects {|record| expect(record).to be_valid }
  end
end
```

#### Avoid validation for specific model 

You can avoid validation for specific models:

```ruby
RSpec.configure do |config|
  config.after type: :system do
    RSpec::AllRecordValidator.validate_all_objects(ignore_models: [DoNotValidatrThisModel]) {|record| expect(record).to be_valid }
  end
end
```

#### For feature spec

You can config This setting for feature spec

```ruby
RSpec.configure do |config|
  config.after type: :feature do
    RSpec::AllRecordValidator.validate_all_objects {|record| expect(record).to be_valid }
  end
end
```
