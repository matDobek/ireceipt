require "net/https"
require "uri"

module Ireceipt
  class Client
    ITUNES_RECEIPT_VALIDATION_TEST_URL = "https://sandbox.itunes.apple.com/verifyReceipt"
    ITUNES_RECEIPT_VALIDATION_PRODUCTION_URL = "https://buy.itunes.apple.com/verifyReceipt"

    def initialize(receipt_data: receipt_data, password: nil)
      @receipt_data = receipt_data
      @password = password
    end

    private

    attr_reader :receipt_data, :password

    def parameters
      parameters_hash = { 'receipt-data' => receipt_data }

      password ?
        parameters_hash.merge({ password: password }) :
        parameters_hash
    end

    def uri
      uri = URI('')
    end

    def request
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      request = Net::HTTP::Post.new(uri.request_uri)
      request['Accept'] = "application/json"
      request['Content-Type'] = "application/json"
      request.body = parameters.to_json

      response = http.request(request)
      JSON.parse(response.body)
    end
  end
end
