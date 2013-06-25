module Chargify2
  class CallResource < Resource

    def self.path
      'calls'
    end

    def self.representation
      Call
    end
    
  end
end
