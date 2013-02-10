# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hipster/version'

Gem::Specification.new do |gem|
  gem.name          = "hipster"
  gem.version       = Hipster::VERSION
  gem.authors       = ["Dirk Gadsden", "Thomas Cannon"]
  gem.email         = ["dirk@esherido.com"]
  gem.description   = "Meta-data fetching before it was cool"
  gem.homepage      = "https://github.com/dirk/hipster"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'httparty'
  gem.add_dependency 'nokogiri'
end
