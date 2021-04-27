require 'rest-client'
require 'multi_json'

module FcEnrich
  class HttpClient
    def post(path, payload_hash)
      response = RestClient.post("https://api.fullcontact.com#{path}",
                                 MultiJson.encode(payload_hash),
                                 authorization: "Bearer #{FcEnrich.api_key}")
      MultiJson.decode(response.body)
    rescue RestClient::NotFound, RestClient::UnprocessableEntity
      nil
    end
  end
end
