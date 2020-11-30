require 'rest-client'
require 'multi_json'

module FullContact
  class HttpClient
    def post(path, payload_hash)
      response = RestClient.post("https://api.fullcontact.com#{path}",
                                 MultiJson.dump(payload_hash),
                                 authorization: "Bearer #{FullContact.api_key}")
      r = MultiJson.load(response.body)
      puts r
      r
    rescue RestClient::NotFound
      nil
    end
  end
end
