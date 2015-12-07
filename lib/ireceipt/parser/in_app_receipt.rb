require 'ireceipt/parser/base'

module Ireceipt::Parser
  # More info about fields:
  # https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html
  class InAppReceipt < Base
    def to_hash
      {
        quantity: "integer",
        product_id: "string",
        transaction_id: "string",
        original_transaction_id: "string",
        web_order_line_item_id: "string",
        purchase_date: "datetime",
        original_purchase_date: "datetime",
        expires_date: "datetime",
        cancellation_date: "datetime",
        is_trial_period: "boolean",
      }.each_with_object({}) do |(key, type), hash|
        hash[key] = send("#{type}_of", key)
      end
    end
  end
end
