require "spec_helper"

describe Chargify2::Offer do
  let(:offer) { described_class.new(successful_response) }

  it "is a Chargify2::Offer object" do
    expect(offer).to be_a(Chargify2::Offer)
  end

  it "it parses the response correctly" do
    expect(offer.name).to eql "Practical Cotton Lamp"
  end

  def successful_response
    {"id"=>2,
     "name"=>"Practical Cotton Lamp",
     "product_family_id"=>2,
     "description"=>nil,
     "price_in_cents"=>1000,
     "interval_unit"=>"month",
     "interval"=>1,
     "product_name"=>"Devolved didactic product",
     "product_id"=>2,
     "coupon_codes"=>[],
     "components"=>[]}
  end
end
