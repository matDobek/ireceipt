require 'json'

module Ireceipt::Parser
  class Base
    def initialize(attributes)
      @attributes = Hash(attributes)
    end

    def to_hash
      raise NotImplementedError
    end
    alias_method :to_h, :to_hash

    def to_json
      to_hash.to_json
    end

    private

    attr_reader :attributes
  end
end
