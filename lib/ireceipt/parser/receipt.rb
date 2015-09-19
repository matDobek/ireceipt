require 'ireceipt/parser/base'

module Ireceipt::Parser
  class Receipt < Base
    def to_hash
      {
        app_item_id: app_item_id,
        bundle_id: bundle_id,
        application_version: application_version,
        download_id: download_id,
        request_date: request_date,
        original_purchase_date: original_purchase_date,
        in_app: in_app,
      }
    end

    private

    # More info about fields:
    # https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html
    {
      app_item_id: "integer",
      bundle_id: "string",
      application_version: "integer",
      download_id: "integer",
      request_date: "datetime",
      original_purchase_date: "datetime",
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

    def in_app
      []
    end
  end
end
