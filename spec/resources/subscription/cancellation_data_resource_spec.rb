require 'spec_helper'

module Chargify2
  describe Subscription::CancellationDataResource do
    it 'should have a correct path' do
      expect(described_class.path).to eq('subscriptions/:subscription_id/cancellation_data')
    end

    it 'represents with the Subscription::CancellationData class' do
      expect(described_class.representation).to eq(Subscription::CancellationData)
    end
  end
end
