# chargify = Chargify::Client.new(:api_id => '123', :api_password => 'passwerd')
#
# call = chargify.calls.read(100)
# call.id
# # => 100
#
# calls = chargify.calls.list
# calls.metadata
#
# chargify.direct
module Chargify2
  class Client
    BASE_URI = "https://api.chargify.com/api/v2"

    attr_reader :api_id
    attr_reader :api_password
    attr_reader :api_secret
    attr_reader :base_uri
    
    def initialize(args = {})
      options = args.symbolize_keys
      
      @api_id       = options[:api_id]
      @api_password = options[:api_password]
      @api_secret   = options[:api_secret]
      @base_uri     = options[:base_uri] || BASE_URI
    end
    
    def direct
      Chargify2::Direct.new(self)
    end
    
    def calls
      Chargify2::Resources::Call.new(self)
    end
  end
end