require 'spec_helper'

describe Ireceipt::Parser::Receipt do
  describe "#to_hash" do
    context "when no keys" do
      it "returns empty hash" do
        result = described_class.new({}).to_hash
        expect(result).to eq({})
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
          "in_app" => []
        }
      end

      it "returns expected hash" do
        expected_hash = {
          app_item_id: 0,
          bundle_id: "com.foo.bar",
          application_version: 0,
          download_id: 0,
          request_date: DateTime.new(2015, 9, 18, 20, 10, 3),
          original_purchase_date: DateTime.new(2013, 8, 1, 7),
          in_app: []
        }

        result = described_class.new(receipt).to_hash

        expect(result).to eq(expected_hash)
      end
    end
  end
end
