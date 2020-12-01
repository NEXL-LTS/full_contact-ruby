module FullContact
  RSpec.describe PersonEnrichRequest do
    let(:http_client) { instance_double(HttpClient) }

    before do
      allow(http_client).to receive(:post).and_return(
        "fullName" => "Bart Lorang",
        "ageRange" => "30-39",
        "gender" => "Male",
        "location" => "Denver, CO, United States",
        "title" => "Co-Founder & Managing Director",
        "organization" => "V1.vc",
        "twitter" => "https://twitter.com/bartlorang",
        "linkedin" => "https://www.linkedin.com/in/bartlorang",
        "facebook" => "https://ww.facebook.com",
        "bio" => "CEO & Co-Founder of @FullContact",
        "avatar" => "https://example.com/static.png",
        "details" => {}
      )
    end

    context 'with email' do
      let(:subject) { described_class.new(email: "bart@fullcontact.com") }

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich", { 'email' => "bart@fullcontact.com" })
      end

      it 'parses the data' do
        response = subject.perform(http_client: http_client)

        expect(response).to have_attributes(full_name: "Bart Lorang", age_range: "30-39", gender: "Male",
                                            location: "Denver, CO, United States",
                                            title: "Co-Founder & Managing Director",
                                            organization: "V1.vc",
                                            twitter: "https://twitter.com/bartlorang",
                                            linkedin: "https://www.linkedin.com/in/bartlorang",
                                            facebook: "https://ww.facebook.com",
                                            bio: "CEO & Co-Founder of @FullContact",
                                            avatar: "https://example.com/static.png")
      end
    end

    context 'with emails' do
      let(:subject) { described_class.new(emails: ["bart@fullcontact.com", "bart.lorang@fullcontact.com"]) }

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with(
          "/v3/person.enrich",
          { 'emails' => ["bart@fullcontact.com", "bart.lorang@fullcontact.com"] }
        )
      end
    end

    context 'with phone' do
      let(:subject) { described_class.new(phone: "+17202227799") }

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'phone' => "+17202227799" })
      end
    end

    context 'with phones' do
      let(:subject) { described_class.new(phones: ["+17202227799", "+13035551234"]) }

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'phones' => ["+17202227799", "+13035551234"] })
      end
    end

    context 'with location' do
      let(:location) {
        { "address_line1": "123 Main Street",
          "address_line2": "Unit 2",
          "city": "Denver",
          "region": "Colorado",
          "region_code": "CO",
          "postal_code": "80203" }
      }
      let(:expected_location) do
        { "addressLine1" => "123 Main Street",
          "addressLine2" => "Unit 2",
          "city" => "Denver",
          "region" => "Colorado",
          "regionCode" => "CO",
          "postalCode" => "80203" }
      end
      let(:subject) do
        described_class.new(location: location)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'location' => expected_location })
      end
    end

    context 'with name' do
      let(:name) {
        { "full": "Bart Lorang",
          "given": "Bart",
          "family": "Lorang" }
      }
      let(:subject) do
        described_class.new(name: name)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'name' => name })
      end
    end

    context 'with profiles' do
      let(:profiles) {
        [{ "service": "twitter", "username": "bartlorang" },
         { "service": "twitter", "userid": "5998422" },
         { "service": "linkedin", "url": "https://www.linkedin.com/in/bartlorang" },
         { "service": "github", "url": "https://www.github.com/lorangb" }]
      }
      let(:subject) do
        described_class.new(profiles: profiles)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'profiles' => profiles })
      end
    end

    context 'with maids' do
      let(:maids) {
        ["ape2ch30-pifn-cbvi-30yy-nia-zex7aw5u"]
      }
      let(:subject) do
        described_class.new(maids: maids)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'maids' => maids })
      end
    end

    context 'with record_id' do
      let(:record_id) { "customer123" }
      let(:subject) do
        described_class.new(record_id: record_id)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'recordId' => record_id })
      end
    end

    context 'with person_id' do
      let(:person_id) { "eYxWc0B-dKRxerTw_uQpxCssM_GyPaLErj0Eu3y2FrU6py1J" }
      let(:subject) do
        described_class.new(person_id: person_id)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'personId' => person_id })
      end
    end

    context 'with data_filter' do
      let(:data_filter) { ["social", "employment_history"] }
      let(:subject) do
        described_class.new(data_filter: data_filter)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'dataFilter' => ["social", "employment_history"] })
      end
    end

    context 'with infer' do
      let(:infer) { false }
      let(:subject) do
        described_class.new(infer: infer)
      end

      it "sends request with correct params" do
        subject.perform(http_client: http_client)

        expect(http_client).to have_received(:post).with("/v3/person.enrich",
                                                         { 'infer' => infer })
      end
    end
  end
end
