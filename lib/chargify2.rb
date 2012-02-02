require 'httparty'
require 'addressable/uri'
require 'hashie'
require 'hashery/opencascade'

require 'chargify2/utils'
require 'chargify2/direct'
require 'chargify2/resource'
require 'chargify2/client'

%w(representations resources).each do |dir|
  Dir[File.dirname(__FILE__) + "/chargify2/#{dir}/*.rb"].each { |file| require file }
end

Hash.send(:include, Chargify2::Utils::HashExtensions)
