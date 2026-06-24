require 'rest-client'
require 'multi_json'

module FcEnrich
  class HttpClient
    def post(path, payload_hash)
      response = RestClient.post("https://api.fullcontact.com#{path}",
                                 MultiJson.encode(payload_hash),
                                 authorization: "Bearer #{FcEnrich.api_key}",
                                 content_type: :json,
                                 accept: :json)
      MultiJson.decode(response.body)
    rescue RestClient::NotFound, RestClient::UnprocessableEntity, RestClient::Gone
      nil
    rescue RestClient::BadRequest => e
      raise FcEnrich::BadRequest.new(e.response)
    end
  end
end
