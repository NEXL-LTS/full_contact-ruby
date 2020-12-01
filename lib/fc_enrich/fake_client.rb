module FcEnrich
  class FakeClient
    def post(path, _payload_hash)
      data = File.read("#{__dir__}/fake_client/post#{path.tr("/", "_")}.json")
      MultiJson.load(data)
    end
  end
end
