module Chargify2
  class Transaction < Hashie::Dash
    property :id
    property :transaction_type
    property :amount_in_cents
    property :ending_balance_in_cents
    property :memo
    property :subscription_id
    property :product_id
    property :success
    property :created_at
    property :request
    property :response
    property :errors

    def self.singular_name
      'transaction'
    end

    def self.plural_name
      'transactions'
    end

    def request
      Request.new(self[:request] || {})
    end

    def response
      Response.new(self[:response] || {})
    end

    def successful?
      response.result.status_code.to_s == '200'
    end

    def errors
      (response.result.errors || []).map {|e| OpenCascade.new(e.deep_symbolize_keys)}
    end

    class Request < OpenCascade; end
    class Response < OpenCascade; end
  end
end

