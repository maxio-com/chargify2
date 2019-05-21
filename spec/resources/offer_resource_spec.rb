require 'spec_helper'

module Chargify2
  describe OfferResource do
    it 'has the correct path' do
      expect(described_class.path).to eql('offers')
    end

    it 'represents the Offer resource' do
      expect(described_class.representation).to eql(Offer)
    end
  end
end
