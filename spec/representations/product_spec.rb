require "spec_helper"

describe Chargify2::Product do
  let(:product) { described_class.new(successful_response) }

  it "is a Chargify2::Product object" do
    expect(product).to be_a(Chargify2::Product)
  end

  it "it parses the response correctly" do
    expect(product.name).to eql "Basic"
  end

  it "has access to the product family" do
    expect(product.product_family_name).to eql "Acme Online"
  end

  private

  def successful_response
    {"id"=>25,
      "name"=>"Basic",
      "handle"=>"handle_2c2e39c77",
      "description"=> "Esse voluptas sunt eos sed iste dicta.",
      "accounting_code"=>nil,
      "price_in_cents"=>2400,
      "interval"=>1,
      "interval_unit"=>"month",
      "initial_charge_in_cents"=>nil,
      "expiration_interval"=>nil,
      "expiration_interval_unit"=>nil,
      "trial_price_in_cents"=>0,
      "trial_interval"=>1,
      "trial_interval_unit"=>"month",
      "return_url"=>nil,
      "return_params"=>nil,
      "request_credit_card"=>true,
      "require_credit_card"=>true,
      "created_at"=>"2013-06-26T11:41:04-04:00",
      "updated_at"=>"2013-06-26T11:41:04-04:00",
      "archived_at"=>nil,
      "update_return_url"=>nil,
      "product_family_name"=> "Acme Online"}
  end
end
