module FullContact
  RSpec.describe HttpClient do
    before do
      allow(FullContact).to receive(:api_key).and_return("TEST!")
    end

    it 'works' do
      stub_request(:post, "https://api.fullcontact.com/v3/person.enrich")
        .with(
          body: "{\"my_data\":\"true\"}",
          headers: { 'Authorization' => 'Bearer TEST!' }
        )
        .to_return(status: 200, body: { "return" => "result" }.to_json)

      data = subject.post("/v3/person.enrich", { my_data: "true" })
      expect(data).to eq("return" => "result")
    end

    it 'handles 404' do
      stub_request(:post, "https://api.fullcontact.com/v3/person.enrich")
        .with(
          body: "{\"my_data\":\"true\"}",
          headers: { 'Authorization' => 'Bearer TEST!' }
        )
        .and_raise(RestClient::NotFound)

      data = subject.post("/v3/person.enrich", { my_data: "true" })
      expect(data).to eq(nil)
    end
  end
end
