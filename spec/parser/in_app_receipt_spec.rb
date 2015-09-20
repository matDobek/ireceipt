require 'spec_helper'

describe Ireceipt::Parser::InAppReceipt do
  describe "#to_hash" do
    context "when no keys" do
      it "returns hash with nil values" do
        expected_hash = {
          quantity: nil,
          product_id: nil,
          transaction_id: nil,
          original_transaction_id: nil,
          web_order_line_item_id: nil,
          purchase_date: nil,
          original_purchase_date: nil,
          expires_date: nil,
          cancellation_date: nil,
          is_trial_period: nil,
        }

        result = described_class.new({}).to_hash

        expect(result).to eq(expected_hash)
      end
    end

    context "when all keys present" do
      let(:in_app) do
        {
          "quantity" => "1",
          "product_id" => "foobar",
          "transaction_id" => "123456789",
          "original_transaction_id" => "123456789",
          "purchase_date" => "2015-05-18 06:07:39 Etc/GMT",
          "purchase_date_ms" => "1431929259000",
          "purchase_date_pst" => "2015-05-17 23:07:39 America/Los_Angeles",
          "original_purchase_date" => "2015-05-18 06:07:39 Etc/GMT",
          "original_purchase_date_ms" => "1431929259000",
          "original_purchase_date_pst" => "2015-05-17 23:07:39 America/Los_Angeles",
          "expires_date" => "2015-05-18 07:07:39 Etc/GMT",
          "expires_date_ms" => "1431932859000",
          "expires_date_pst" => "2015-05-18 00:07:39 America/Los_Angeles",
          "cancellation_date" => "2015-05-18 07:07:39 Etc/GMT",
          "cancellation_date_ms" => "1431932859000",
          "cancellaction_date_pst" => "2015-05-18 00:07:39 America/Los_Angeles",
          "web_order_line_item_id" => "111111111",
          "is_trial_period" => "true"
        }
      end

      it "returns expected hash" do
        expected_hash = {
          quantity: 1,
          product_id: "foobar",
          transaction_id: "123456789",
          original_transaction_id: "123456789",
          purchase_date: DateTime.new(2015, 5, 18, 6, 7, 39),
          original_purchase_date: DateTime.new(2015, 5, 18, 6, 7, 39),
          expires_date: DateTime.new(2015, 5, 18, 7, 7, 39),
          cancellation_date: DateTime.new(2015, 5, 18, 7, 7, 39),
          web_order_line_item_id: "111111111",
          is_trial_period: true,
        }

        result = described_class.new(in_app).to_hash

        expect(result).to eq(expected_hash)
      end
    end
  end
end
