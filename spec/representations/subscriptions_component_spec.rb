require "spec_helper"

describe Chargify2::SubscriptionsComponent do
  let(:subscriptions_component) { described_class.new(raw_response) }

  it "is a Chargify2::SubscriptionsComponent object" do
    expect(subscriptions_component).to be_a(Chargify2::SubscriptionsComponent)
  end

  it "can read an attribute from the response" do
    expect(subscriptions_component.id).to eql(123)
  end

  private
  def raw_response
    {
      "id" => 123
    }
  end
end
