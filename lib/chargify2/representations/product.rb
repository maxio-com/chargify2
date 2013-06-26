module Chargify2
  class Product < Representation
    property :id
    property :name
    property :handle
    property :accounting_code
    property :description
    property :price_in_cents
    property :interval_unit
    property :interval
    property :initial_charge_in_cents
    property :trial_price_in_cents
    property :trial_interval
    property :trial_interval_unit
    property :expiration_interval_unit
    property :expiration_interval
    property :return_url
    property :update_return_url
    property :return_params
    property :require_credit_card
    property :request_credit_card
    property :created_at
    property :updated_at
    property :archived_at
    property :product_family, transform_with: lambda {|product_family| ProductFamily.new(product_family)}
  end
end

