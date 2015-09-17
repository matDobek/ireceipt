require 'spec_helper'

describe Ireceipt::Response::Base do
  let(:base) { described_class.new(attributes) }
  let(:attributes) do
    {
      foo: 'foo',
      bar: 'bar'
    }
  end

  describe '#to_json' do
    it 'returns proper JSON object' do
      allow(base).to receive(:to_hash).and_return({id: 1})

      result = base.to_json

      expect(result).to eq('{"id":1}')
    end
  end

  describe '#to_hash' do
    it 'raises an not implemented error' do
      expect { base.to_hash }.to raise_error(NotImplementedError)
    end
  end

  describe '#to_h' do
    it 'is an alias for #to_hash' do
      result = base.method(:to_h)

      expect(result).to eq base.method(:to_hash)
    end
  end
end
