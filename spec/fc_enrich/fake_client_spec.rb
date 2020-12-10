module FcEnrich
  RSpec.describe FakeClient do
    it 'works for /v3/person.enrich' do
      data = subject.post("/v3/person.enrich", { email: "bart@fullcontact.com" })
      expect(data).to include("ageRange" => "30-39", "fullName" => "Bart Lorang",
                              "gender" => "Male", "organization" => "V1.vc",
                              "linkedin" => "https://www.linkedin.com/in/bartlorang",
                              "title" => "Co-Founder & Managing Director",
                              "twitter" => "https://twitter.com/bartlorang",
                              "details" => {
                                "locations" => [{ "city" => "Denver", "country" => "United States", "region" => "CO" }],
                                "name" => { "family" => "Lorang", "given" => "Bart" }
                              })
    end

    it 'works for /v3/person.enrich that do not exist' do
      data = subject.post("/v3/person.enrich", { email: "someone@mail.com" })
      expect(data).to be_blank
    end

    it 'works for /v3/company.enrich' do
      data = subject.post("/v3/company.enrich", { domain: "fullcontact.com" })
      expect(data).to include("name" => "FullContact, Inc.")
    end

    it 'works for /v3/company.enrich that do not exist' do
      data = subject.post("/v3/company.enrich", { domain: "someone.com" })
      expect(data).to be_blank
    end

    it 'allows to change folder' do
      described_class.folder = "#{__dir__}/../tmp"
      puts described_class.folder

      data = subject.post("/v3/person.enrich", { email: "bart@fullcontact.com" })
      expect(data).to include("fullName" => "Bart Lorang")

      data = subject.post("/v3/company.enrich", { domain: "fullcontact.com" })
      expect(data).to include("name" => "FullContact, Inc.")
    end
  end
end
