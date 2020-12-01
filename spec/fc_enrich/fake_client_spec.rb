module FcEnrich
  RSpec.describe FakeClient do
    it 'works for /v3/person.enrich' do
      data = subject.post("/v3/person.enrich", { my_data: "true" })
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
  end
end
