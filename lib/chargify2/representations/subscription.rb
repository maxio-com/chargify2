module Chargify2
  class Subscription < Hashie::Dash
    property :id
    property :state
    property :balance_in_cents
    property :current_period_started_at
    property :current_period_ends_at
    property :next_assessment_at
    property :trial_started_at
    property :trial_ended_at
    property :activated_at
    property :expires_at
    property :created_at
    property :updated_at
    property :customer
    property :product
    property :credit_card
    property :cancellation_message
    property :canceled_at
    property :signup_revenue
    property :signup_payment_id
    property :delayed_cancel_at
    property :previous_state
    property :coupon_code
    # why aren't these in subscription#show?
    property :cancel_at_end_of_period
    property :payment_collection_method
    property :total_revenue_in_cents
    
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
      (response.result.errors || []).map {|e| OpenCascade.new(e.symbolize_keys)}
    end
    
    class Request < Hashery::OpenCascade; end
    class Response < Hashery::OpenCascade; end
  end
end

