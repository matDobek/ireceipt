require 'ireceipt/parser/base'

module Ireceipt::Parser
  class InAppReceipt < Base
    def to_hash
      {
        quantity: quantity,
        product_id: product_id,
        transaction_id: transaction_id,
        original_transaction_id: original_transaction_id,
        web_order_line_item_id: web_order_line_item_id,
        purchase_date: purchase_date,
        original_purchase_date: original_purchase_date,
        expires_date: expires_date,
        cancellation_date: cancellation_date,
        is_trial_period: is_trial_period,
      }
    end

    private

    # More info about fields:
    # https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html
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
    }.each do |key, type|
      define_method(key) do
        unless instance_variable_get("@#{key}").nil?
          return instance_variable_get("@#{key}")
        end

        if key_present?(key)
          instance_variable_set(
            "@#{key}",
            send("#{type}_of", key)
          )
        end
      end
    end
  end
end
