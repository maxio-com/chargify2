module Chargify2
  class Transaction < Representation
    property :id
    property :transaction_type
    property :amount_in_cents
    property :created_at
    property :starting_balance_in_cents
    property :ending_balance_in_cents
    property :memo
    property :success
    property :kind
    property :subscription_id
    property :product_id
    property :payment_id
    property :gateway_transaction_id
  end
end
