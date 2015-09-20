require 'spec_helper'

describe Ireceipt::Parser::Receipt do
  describe "#to_hash" do
    context "when no keys" do
      it "returns hash with nil values" do
        expected_hash = {
          app_item_id: nil,
          bundle_id: nil,
          application_version: nil,
          download_id: nil,
          request_date: nil,
          original_purchase_date: nil,
          in_app: nil
        }

        result = described_class.new({}).to_hash

        expect(result).to eq(expected_hash)
      end
    end

    context "when all keys present" do
      let(:receipt) do
        {
          "receipt_type" => "ProductionSandbox",
          "adam_id" => 0,
          "app_item_id" => 0,
          "bundle_id" => "com.foo.bar",
          "application_version" => "0",
          "download_id" => 0,
          "version_external_identifier" => 0,
          "request_date" => "2015-09-18 20:10:03 Etc/GMT",
          "request_date_ms" => "1442607003200",
          "request_date_pst" => "2015-09-18 13:10:03 America/Los_Angeles",
          "original_purchase_date" => "2013-08-01 07:00:00 Etc/GMT",
          "original_purchase_date_ms" => "1375340400000",
          "original_purchase_date_pst" => "2013-08-01 00:00:00 America/Los_Angeles",
          "original_application_version" => "1.0",
          "in_app" => [
            { "product_id" => "foobar" },
            { "product_id" => "barfoo"}
          ]
        }
      end

      it "returns expected hash" do
        result = described_class.new(receipt).to_hash

        expect(result[:app_item_id]).to eq(0)
        expect(result[:bundle_id]).to eq("com.foo.bar")
        expect(result[:application_version]).to eq(0)
        expect(result[:download_id]).to eq(0)
        expect(result[:request_date]).to eq DateTime.new(2015, 9, 18, 20, 10, 3)
        expect(result[:original_purchase_date]).to eq DateTime.new(2013, 8, 1, 7)
        expect(result[:in_app].count).to eq(2)
      end
    end
  end
end
