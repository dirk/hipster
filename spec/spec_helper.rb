# http://stackoverflow.com/questions/4398262/setup-rspec-to-test-a-gem-not-rails

require 'rubygems'
require 'bundler/setup'
require 'rspec/autorun'

require 'hipster'

RSpec.configure do |config|
  # some (optional) config here
  config.color_enabled = true
  config.formatter = :documentation

	# Run specs in random order to surface order dependencies. If you find an
	# order dependency and want to debug it, you can fix the order by providing
	# the seed, which is printed after each run.
	#     --seed 1234
	config.order = "random"

end
