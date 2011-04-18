require 'httparty'
require 'addressable/uri'
require 'hashie'
require 'hashery/opencascade'

Dir["#{File.dirname(__FILE__)}/chargify2/**/*.rb"].each {|f| require f}

Hash.send(:include, Chargify2::Utils::HashExtensions)
