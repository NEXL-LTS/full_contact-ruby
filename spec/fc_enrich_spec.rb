RSpec.describe FcEnrich do
  it "has a version number" do
    expect(FcEnrich::VERSION).not_to be nil
  end

  it 'can set api key' do
    described_class.api_key = "TEST!"

    expect(described_class).to have_attributes(api_key: "TEST!")
  end

  it 'returns real client' do
    expect(described_class.http_client).to be_kind_of(FcEnrich::HttpClient)
  end

  it 'returns fake person enrich with bart@fullcontact.com' do
    allow(described_class).to receive(:use_fake?).and_return(true)

    person_request = FcEnrich::PersonEnrichRequest.new(email: "bart@fullcontact.com")
    person = person_request.perform
    expect(person.full_name).to eq("Bart Lorang")
  end

  it 'returns fake company enrich' do
    allow(described_class).to receive(:use_fake?).and_return(true)

    person_request = FcEnrich::CompanyEnrichRequest.new(domain: "fullcontact.com")
    person = person_request.perform
    expect(person.name).to eq("FullContact, Inc.")
  end
end
