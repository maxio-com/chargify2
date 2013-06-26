module Chargify2
  class Call < Representation
    property :id
    property :api_id
    property :timestamp
    property :nonce
    property :success
    property :request
    property :response
  end
end
