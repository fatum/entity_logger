# -*- encoding: utf-8 -*-
require File.expand_path('../lib/entity_logger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["m.filippovich"]
  gem.email         = ["fatumka@gmail.com"]
  gem.description   = %q{Entity logger}
  gem.summary       = %q{Extend entity with tag logging}
  gem.homepage      = "http://twitter.com/mfilippovich"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "entity_logger"
  gem.require_paths = ["lib"]
  gem.version       = EntityLogger::VERSION

  gem.add_dependency 'activesupport', '>= 3.1'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
end
