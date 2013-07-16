module Chargify2
  class BillingManifest < Representation
    property :end_date
    property :line_items
    property :start_date
    property :subtotal_in_cents
    property :total_discount_in_cents
    property :total_in_cents
    property :total_tax_in_cents
    property :period_type
  end
end
