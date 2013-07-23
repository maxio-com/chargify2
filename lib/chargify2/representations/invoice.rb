module Chargify2
  class Invoice < Representation
    property :id
    property :number
    property :display_number
    property :subscription_id
    property :statement_id
    property :site_id
    property :state
    property :total_amount_in_cents
    property :paid_at
    property :created_at
    property :updated_at
    property :amount_due_in_cents
    property :transactions, transform_with: lambda {|transactions| transactions.map{|t| Transaction.new(t)}}
  end
end
