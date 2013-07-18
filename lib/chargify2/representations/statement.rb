module Chargify2
  class Statement < Representation
    property :id
    property :subscription, transform_with: lambda {|subscription| Subscription.new(subscription)}
    property :customer, transform_with: lambda {|customer| Customer.new(customer)}
    property :invoice, transform_with: lambda {|invoice| Invoice.new(invoice)}
    property :created_at
    property :updated_at
    property :opened_at
    property :closed_at
    property :settled_at
    property :future_payments
    property :starting_balance_in_cents
    property :ending_balance_in_cents
    property :memo
    property :transactions, transform_with: lambda {|transactions| transactions.map{|t| Transaction.new(t)}}
  end
end
