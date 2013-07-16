module Chargify2
  class Migration < Representation
    property :billing_manifest, transform_with: lambda {|billing_manifest| BillingManifest.new(billing_manifest)}
  end
end
