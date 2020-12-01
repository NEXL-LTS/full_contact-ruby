require 'rest-client'
require 'multi_json'

module FullContact
  class HttpClient
    def post(path, payload_hash)
      response = RestClient.post("https://api.fullcontact.com#{path}",
                                 MultiJson.encode(payload_hash),
                                 authorization: "Bearer #{FullContact.api_key}")
      MultiJson.decode(response.body)
    rescue RestClient::NotFound
      nil
    end
  end
end
