module Chargify2
  class OfferResource < Resource

    def self.path
      'offers'
    end

    def self.representation
      Offer
    end

  end
end
