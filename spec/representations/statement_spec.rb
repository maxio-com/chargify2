require "spec_helper"

describe Chargify2::Statement do
  let(:statement) { described_class.new(raw_response) }

  it "is a Chargify2::Statement object" do
    expect(statement).to be_a(Chargify2::Statement)
  end

  it "it parses the response correctly" do
    expect(statement.id).to eql(374)
  end

  it "has access to the subscription" do
    expect(statement.subscription.class).to eql(Chargify2::Subscription)
    expect(statement.subscription.state).to eql("active")
  end

  it "has access to the customer" do
    expect(statement.customer.class).to eql(Chargify2::Customer)
    expect(statement.customer.first_name).to eql("David")
  end

  it "has access to the invoice" do
    expect(statement.invoice.class).to eql(Chargify2::Invoice)
    expect(statement.invoice.display_number).to eql("000001")
  end

  it "has access to the transactions" do
    expect(statement.transactions.first.class).to eql(Chargify2::Transaction)
    expect(statement.transactions.first.kind).to eql("baseline")
  end

  private

  def raw_response
    puts "REPLACE ME!"
  end
end
