require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'r_factor'

require 'minitest/autorun'
