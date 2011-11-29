require 'httparty'
require 'addressable/uri'
require 'hashie'
require 'hashery/opencascade'

require 'chargify2/utils'
require 'chargify2/direct'
require 'chargify2/resource'
require 'chargify2/client'
require 'chargify2/representations/call'
require 'chargify2/resources/call_resource'
require 'chargify2/representations/site'
require 'chargify2/resources/site_resource'
require 'chargify2/representations/transaction'
require 'chargify2/resources/transaction_resource'

Hash.send(:include, Chargify2::Utils::HashExtensions)
