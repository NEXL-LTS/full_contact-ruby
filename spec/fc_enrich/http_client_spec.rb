module FcEnrich
  RSpec.describe HttpClient do
    before do
      allow(FcEnrich).to receive(:api_key).and_return("TEST!")
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
      expect(data).to be_nil
    end

    it 'handles 400' do
      stub_request(:post, "https://api.fullcontact.com/v3/person.enrich")
        .with(
          body: "{\"email\":\"bad_email_format\"}",
          headers: { 'Authorization' => 'Bearer TEST!' }
        )
        .and_raise(
          RestClient::BadRequest.new({ "status" => 400, "message" => "Invalid email format" }.to_json)
        )

      expect {
        subject.post("/v3/person.enrich", { email: "bad_email_format" })
      }.to(raise_error { |err|
        expect(err.message).to eq('Invalid email format')
        expect(err.status).to be(400)
      })
    end

    it 'handles 422' do
      stub_request(:post, "https://api.fullcontact.com/v3/person.enrich")
        .with(
          body: "{\"my_data\":\"true\"}",
          headers: { 'Authorization' => 'Bearer TEST!' }
        )
        .to_return(status: 422, body: "", headers: {})

      data = subject.post("/v3/person.enrich", { my_data: "true" })
      expect(data).to be_nil
    end
  end
end
