require "spec_helper"

describe Chargify2::Allocation do
  let(:allocation) { described_class.new(raw_response) }

  it "is a Chargify2::Allocation object" do
    expect(allocation).to be_a(Chargify2::Allocation)
  end

  it "can read an attribute from the response" do
    expect(allocation.id).to eql(9)
  end

  private
  def raw_response
    {
      "id" => 9
    }
  end
end

