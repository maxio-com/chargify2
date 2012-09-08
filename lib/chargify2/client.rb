module Chargify2
  class Client
    BASE_URI = "https://api.chargify.com/api/v2"
    
    attr_reader :api_id
    attr_reader :api_password
    attr_reader :api_secret
    attr_reader :base_uri

    def initialize(options = {})
      @api_id = options[:api_id] || options['api_id']
      @api_password = options[:api_password] || options['api_password']
      @api_secret = options[:api_secret] || options['api_secret']
      @base_uri = options[:base_uri] || BASE_URI
    end
    
    def direct
      @direct ||= Direct.new(self)
    end
    
    def results
      Result.new("#{URI}/results")
    end
  end
end