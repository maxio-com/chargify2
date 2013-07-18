module Chargify2
  class StatementResource < Resource

    def self.path
      'statements'
    end

    def self.representation
      Statement
    end

  end
end
