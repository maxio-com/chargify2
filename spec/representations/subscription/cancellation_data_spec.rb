require 'spec_helper'

describe Chargify2::Subscription::CancellationData do
  let(:cancellation_data) { described_class.new(raw_response) }

  it 'is a Chargify2::Subscription::CancellationData object' do
    expect(cancellation_data).to be_a(Chargify2::Subscription::CancellationData)
  end

  it 'can read an attribute from the response' do
    expect(cancellation_data.id).to eql(123)
  end

  def raw_response
    {
      'id' => 123
    }
  end
end
