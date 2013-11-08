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
      options = Utils.deep_symbolize_keys(args)

      @api_id       = options.api_id
      @api_password = options.api_password
      @api_secret   = options.api_secret
      @base_uri     = options.base_uri || BASE_URI
    end

    def direct
      Chargify2::Direct.new(self)
    end

    def calls
      Chargify2::CallResource.new(self)
    end

    def customers
      Chargify2::CustomerResource.new(self)
    end

    def migrations
      Chargify2::MigrationResource.new(self)
    end

    def products
      Chargify2::ProductResource.new(self)
    end

    def statements
      Chargify2::StatementResource.new(self)
    end

    def subscriptions
      Chargify2::SubscriptionResource.new(self)
    end

    def subscriptions_components
      Chargify2::SubscriptionsComponentResource.new(self)
    end

    def allocations
      Chargify2::AllocationResource.new(self)
    end

    def allocation_previews
      Chargify2::AllocationPreviewResource.new(self)
    end
  end
end
