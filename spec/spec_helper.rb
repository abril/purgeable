# encoding: UTF-8
require "rubygems"

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

lib_path = File.expand_path('../../lib', __FILE__)
$:.unshift lib_path unless $:.include? lib_path

require 'ruby-debug'
require 'rspec' unless defined? RSpec
require "fakeweb"
require 'purgeable'

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.mock_with :mocha
end
