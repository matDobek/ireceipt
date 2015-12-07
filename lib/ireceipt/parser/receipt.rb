require 'ireceipt/parser/base'
require 'ireceipt/parser/in_app_receipt'

module Ireceipt::Parser
  # More info about fields:
  # https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html
  class Receipt < Base
    def to_hash
      hash = { in_app: in_app }

      {
        app_item_id: "integer",
        bundle_id: "string",
        application_version: "integer",
        download_id: "integer",
        request_date: "datetime",
        original_purchase_date: "datetime",
      }.each_with_object(hash) do |(key, type), hash|
        hash[key] = send("#{type}_of", key)
      end
    end

    private

    def in_app
      @in_app ||= Array(
        attributes.fetch("in_app") { nil }
      ).map { |item| InAppReceipt.new(item).to_hash }
    end
  end
end
