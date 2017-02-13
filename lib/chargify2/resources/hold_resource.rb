module Chargify2
  class HoldResource < Resource
    def self.path
      'holds'
    end

    def self.representation
      Hold
    end
  end
end
