require 'httparty'
require 'rack'
require 'hashie'
require 'hashery/open_cascade'

require 'chargify2/utils'
require 'chargify2/direct'
require 'chargify2/resource'
require 'chargify2/client'
require 'chargify2/representations/call'
require 'chargify2/resources/call_resource'

Hash.send(:include, Chargify2::Utils::HashExtensions)
