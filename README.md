# EntityLogger

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'entity_logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install entity_logger

## Usage
```ruby
require 'entity_logger'

class Entity
  include EntityLogger::Mixin

  log Logger.new(STDOUT), 'Prefix', :some_attr, or_lambda: { |e| e.some_attr + e.some_attr1 }

  def some_attr
    'Some attr'
  end

  def some_attr1
    1
  end
end

entity = Entity.new
entity.info 'Some log message'
# Prefix [Some attr] [Some attr1] Some log message
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
