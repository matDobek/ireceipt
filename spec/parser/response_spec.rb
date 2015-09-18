require 'spec_helper'

describe Ireceipt::Parser::Response do
  let(:response) do
    {
      "status" => 0,
      "receipt" => {},
      "latest_receipt_info" => [],
      "latest_receipt" => "receipt"
    }
  end

  describe "#to_hash" do
    it "returns expected hash" do
      expected_hash = {
        status: 0,
        receipt: {},
        latest_receipt_info: [],
        latest_receipt: "receipt"
      }

      result = described_class.new(response).to_hash

      expect(result).to eq(expected_hash)
    end
  end
end
