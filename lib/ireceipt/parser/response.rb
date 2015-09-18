require 'ireceipt/parser/base'

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
      attributes.fetch("status")
    end

    def receipt
      attributes.fetch("receipt") { Hash.new }
    end

    def latest_receipt_info
      attributes.fetch("latest_receipt_info") { Array.new }
    end

    def latest_receipt
      attributes.fetch("latest_receipt") { "" }
    end
  end
end
