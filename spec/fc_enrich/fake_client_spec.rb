module FcEnrich
  RSpec.describe FakeClient do
    it 'works for /v3/person.enrich' do
      data = subject.post("/v3/person.enrich", { my_data: "true" })
      expect(data).to include("ageRange" => "30-39",
                              "details" => {},
                              "fullName" => "Bart Lorang",
                              "gender" => "Male",
                              "linkedin" => "https://www.linkedin.com/in/bartlorang",
                              "location" => "Denver, CO, United States",
                              "organization" => "V1.vc",
                              "title" => "Co-Founder & Managing Director",
                              "twitter" => "https://twitter.com/bartlorang")
    end
  end
end
