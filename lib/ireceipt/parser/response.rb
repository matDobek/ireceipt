require 'ireceipt/parser/base'
require 'ireceipt/parser/receipt'
require 'ireceipt/parser/in_app_receipt'

module Ireceipt::Parser
  # Detailed description:
  # https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html
  class Response < Base
    def to_hash
      {
        status: status,
        receipt: receipt,
        latest_receipt_info: latest_receipt_info,
        latest_receipt: latest_receipt,
      }
    end

    private

    def status
      @status ||= attributes.fetch("status").to_i
    end

    def receipt
      @receipt ||= Receipt.new(
        attributes.fetch("receipt") { nil }
      ).to_hash
    end

    def latest_receipt_info
      @latest_receipt_info ||= Array(
        attributes.fetch("latest_receipt_info") { nil }
      ).map { |item| InAppReceipt.new(item).to_hash }
    end

    def latest_receipt
      @latest_receipt ||= attributes.fetch("latest_receipt") { nil }
    end
  end
end
