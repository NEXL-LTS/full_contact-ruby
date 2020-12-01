require 'rest-client'
require 'multi_json'

module FullContactApi
  class HttpClient
    def post(path, payload_hash)
      response = RestClient.post("https://api.fullcontact.com#{path}",
                                 MultiJson.encode(payload_hash),
                                 authorization: "Bearer #{FullContactApi.api_key}")
      MultiJson.decode(response.body)
    rescue RestClient::NotFound
      nil
    end
  end
end
