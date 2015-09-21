require 'spec_helper'

describe Ireceipt::Parser::Response do

  describe "#to_hash" do
    context "when no expected keys" do
      let(:response) do
        {
          "status" => 0
        }
      end

      it "returns hash with nil values" do
        expected_hash = {
          status: 0,
          receipt: nil,
          latest_receipt_info: nil,
          latest_receipt: nil
        }

        result = described_class.new(response).to_hash

        expect(result).to eq(expected_hash)
      end
    end

    context "when all keys present" do
      let(:response) do
        {
          "status" => 0,
          "receipt" => {},
          "latest_receipt_info" => [],
          "latest_receipt" => "receipt"
        }
      end

      it "returns expected hash" do
        expected_hash = {
          status: 0,
          receipt:
          {
            app_item_id: nil,
            bundle_id: nil,
            application_version: nil,
            download_id: nil,
            request_date: nil,
            original_purchase_date: nil,
            in_app: nil
          },
          latest_receipt_info: [],
          latest_receipt: "receipt"
        }

        result = described_class.new(response).to_hash

        expect(result).to eq(expected_hash)
      end
    end
  end
end
