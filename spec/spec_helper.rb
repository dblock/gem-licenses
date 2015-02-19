require 'rubygems'
require 'bundler/setup'
require 'rspec'

require File.expand_path('../../lib/gem_licenses', __FILE__)

RSpec.configure(&:raise_errors_for_deprecations!)
