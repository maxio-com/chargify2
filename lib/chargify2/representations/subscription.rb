module Chargify2
  class Subscription < Representation
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
    property :customer,    transform_with: lambda {|cust| Customer.new(cust)}
    property :product,     transform_with: lambda {|prod| Product.new(prod)}
    property :credit_card, transform_with: lambda {|cc|   CreditCard.new(cc)}
    property :cancellation_message
    property :canceled_at
    property :signup_revenue
    property :signup_payment_id
    property :delayed_cancel_at
    property :previous_state
    property :coupon_code
    property :cancel_at_end_of_period
    property :payment_collection_method
    property :total_revenue_in_cents
    
  end
end

