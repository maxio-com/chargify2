require 'httparty'
require 'addressable/uri'
require 'hashie'
require 'hashery/opencascade'

require 'chargify2/utils'
require 'chargify2/direct'
require 'chargify2/resource'
require 'chargify2/client'
require 'chargify2/representations/call'
require 'chargify2/representations/subscription'
require 'chargify2/resources/call_resource'
require 'chargify2/resources/subscription_resource'

Hash.send(:include, Chargify2::Utils::HashExtensions)
