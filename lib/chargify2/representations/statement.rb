module Chargify2
  class Statement < Representation
    property :subscription, transform_with: lambda {|subscription| Subscription.new(subscription)}
    property :customer,     transform_with: lambda {|customer| Customer.new(customer)}

    property :invoice,      transform_with: lambda {|invoice| Invoice.new(invoice)}
    property :transactions, transform_with: lambda {|transactions| transactions.map{|t| Transaction.new(t)}}
    property :events,       transform_with: lambda {|events| events.map{|e| Event.new(e)}}

    property :id
    property :index
    property :created_at
    property :updated_at
    property :opened_at
    property :closed_at
    property :settled_at
    property :future_payments
    property :starting_balance_in_cents
    property :ending_balance_in_cents
    property :memo
    property :product_name
    property :product_family_name
    property :billing_address
    property :billing_address_2
    property :billing_city
    property :billing_state
    property :billing_country
    property :billing_zip
    property :shipping_address
    property :shipping_address_2
    property :shipping_city
    property :shipping_state
    property :shipping_country
    property :shipping_zip
    property :business_name
    property :business_email
  end
end
