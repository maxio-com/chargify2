require "spec_helper"

describe Chargify2::ReasonCodes do
  let(:reason_codes) { described_class.new(successful_response) }

  it "is a Chargify2::ReasonCode object" do
    expect(reason_codes).to be_a(Chargify2::ReasonCodes)
  end

  it "it parses the response correctly" do
    expect(reason_codes.reason_codes[0].code).to eql "CARO"
  end

  it "has access to the product family" do
    expect(reason_codes.reason_codes[0].description).to eql "Too Expensive"
  end

  private

  def successful_response
    {"reason_codes" => [{"code" => "CARO","description"=>"Too Expensive","position"=>1}]}
  end
end
