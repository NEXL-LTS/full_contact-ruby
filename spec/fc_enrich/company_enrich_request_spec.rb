module FcEnrich
  RSpec.describe CompanyEnrichRequest do
    let(:http_client) { instance_double(HttpClient) }

    before do
      allow(http_client).to receive(:post).and_return(
        MultiJson.load(
          File.read("#{__dir__}/company_enrich_response_example.json")
        )
      )
    end

    context 'with domain' do
      let(:subject) { described_class.new(domain: "fullcontact.com") }

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/company.enrich", { 'domain' => "fullcontact.com" })
      end

      it 'parses the data' do
        response = subject.perform(http_client: http_client)

        expect(response).to have_attributes(name: "FullContact, Inc.",
                                            location: "1755 Blake Street, Suite 450, Denver, Colorado, United States",
                                            twitter: "@fullcontact",
                                            linkedin: "https://www.linkedin.com/company/fullcontact-inc-",
                                            bio: "FullContact is the ... contacts and be awesome with people.",
                                            logo: "https://d2ojpxxtu63wzl.cloudfront.net/stati...8ea9e4d47f5af6c",
                                            website: "https://www.fullcontact.com",
                                            founded: 2010, employees: 350, locale: "en",
                                            category: "Other")
      end
    end

    context 'with webhook_url' do
      let(:subject) { described_class.new(webhook_url: "webhook_url") }

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with(
          "/v3/company.enrich",
          { 'webhookUrl' => "webhook_url" }
        )
      end
    end
  end
end
