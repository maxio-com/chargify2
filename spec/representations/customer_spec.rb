require "spec_helper"

describe Chargify2::Customer do
  let(:customer) { described_class.new(successful_response) }

  it "is a Chargify2::Customer object" do
    expect(customer).to be_a(Chargify2::Customer)
  end

  it "it parses the response correctly" do
    expect(customer.first_name).to eql "Bro"
  end

  private

  def successful_response
    {"id"=>24,
      "first_name"=>"Bro",
      "last_name"=>"Montana",
      "email"=>"bro.montana@example.com",
      "organization"=>"",
      "reference"=>nil,
      "address"=>"",
      "address_2"=>"",
      "city"=>"",
      "state"=>"",
      "zip"=>"",
      "country"=>"",
      "phone"=>"",
      "created_at"=>"2013-06-28T13:36:35-04:00",
      "updated_at"=>"2013-07-15T15:03:15-04:00"}
  end
end
