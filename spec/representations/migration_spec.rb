require "spec_helper"

describe Chargify2::Migration do
  let(:migration) { described_class.new(successful_response) }

  it "is a Chargify2::Migration object" do
    expect(migration).to be_a(Chargify2::Migration)
  end

  it "has access to a Chargify2::BillingManifest object" do
    expect(migration.billing_manifest).to be_a(Chargify2::BillingManifest)
  end

  private

  def successful_response
    {"billing_manifest"=>
      {"line_items"=>
        [{"memo"=>"Prorated credit for (Acme Online) Pro",
          "amount_in_cents"=>-9869,
          "discount_amount_in_cents"=>0,
          "transaction_type"=>"adjustment",
          "taxable_amount_in_cents"=>0,
          "kind"=>"prorated"},
          {"memo"=>"Basic (07/15/2013 - 08/15/2013)",
            "amount_in_cents"=>2400,
            "discount_amount_in_cents"=>0,
            "transaction_type"=>"charge",
            "taxable_amount_in_cents"=>0,
            "kind"=>"baseline"}],
            "total_discount_in_cents"=>0,
            "subtotal_in_cents"=>-7469,
            "total_in_cents"=>-7469,
            "start_date"=>"2013-07-15T17:55:03-04:00",
            "total_tax_in_cents"=>0,
            "end_date"=>"2013-08-15T17:55:03-04:00",
            "period_type"=>"recurring"}}
  end
end
