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

    def boolean_of(key)
      safe_fetch do
        attributes.fetch(key.to_s) == "true"
      end
    end

    def integer_of(key)
      safe_fetch do
        attributes.fetch(key.to_s).to_i
      end
    end

    def string_of(key)
      safe_fetch do
        attributes.fetch(key.to_s).to_s
      end
    end

    def datetime_of(key)
      safe_fetch do
        DateTime.parse(attributes.fetch(key.to_s))
      end
    end

    def safe_fetch
      yield
    rescue ::KeyError
    end
  end
end
