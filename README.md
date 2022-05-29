# RSpec::AllRecordsValidator

Check all ActiveRecord object validation which has `has_many` association after system spec.

This gem is designed for: [rspec-rails](https://github.com/rspec/rspec-rails)

## Setup

### Install 

Add this line to your application's Gemfile in test group:

```ruby
group :test do
  gem 'rspec-all_records_validator'
end
```

And then execute:

```
$ bundle install
```

### Configure

Add below to your `spec_helper.rb`

```ruby
require 'rspec/all_records_validator'

RSpec.configure do |config|
  config.after type: :system do
    RSpec::AllRecordsValidator.validate!
  end
end
```

#### Avoid validation for specific model 

You can avoid validation for specific models:

```ruby
RSpec.configure do |config|
  config.after type: :system do
    RSpec::AllRecordsValidator.validate!(ignored_models: [DoNotValidateThisModel])
  end
end
```

#### For feature spec

You can config This setting for feature spec

```ruby
RSpec.configure do |config|
  config.after type: :feature do
    RSpec::AllRecordsValidator.validate!
  end
end
```

### Pro Tip

If you use fixture or master data, ignore them is good for speed.

```ruby
RSpec::AllRecordsValidator.validate!(ignored_models: [MasterDataModel])
```

## Contributing

Send me your pull requests.
