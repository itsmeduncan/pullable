require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pullable'
require 'mocha/api'

RSpec.configure do |config|
  config.mock_framework = :mocha
end
