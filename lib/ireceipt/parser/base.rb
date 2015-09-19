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

    def key_present?(key)
      attributes.key?(key.to_s)
    end

    def integer_of(key)
      attributes.fetch(key.to_s).to_i
    end

    def string_of(key)
      attributes.fetch(key.to_s).to_s
    end

    def datetime_of(key)
      DateTime.parse(attributes.fetch(key.to_s))
    end
  end
end
