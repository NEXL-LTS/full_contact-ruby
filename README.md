# Full Contact Api
[![Build Status](https://travis-ci.org/NEXL-LTS/full_contact-ruby.svg?branch=main)](https://travis-ci.org/NEXL-LTS/full_contact-ruby)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fc_enrich'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fc_enrich

## Usage

```ruby
  # setup
  FcEnrich.api_key = "[API_KEY]"
```

#### Person Enrich

see https://platform.fullcontact.com/docs/apis/enrich/multi-field-request

```ruby
  person_request = FcEnrich::PersonEnrichRequest.new(email: "bart@fullcontact.com")
  person = person_request.perform
  puts person.full_name # "Bart Lorang"
  puts person.age_range # "30-39"
  puts person.gender # "Male"
  puts person.location # "Denver, CO, United States"
  puts person.title # "Co-Founder & Managing Director"
  puts person.organization # "V1.vc"
  puts person.twitter # "https://twitter.com/bartlorang"
  puts person.linkedin # "https://www.linkedin.com/in/bartlorang"
  puts person.bio # "CEO & Co-Founder of @FullContact, Managing Director @v1vc_. Tech Entrepreneur, Investor."
  puts person.avatar # "https://d2ojpxxtu63wzl.cloudfront.net/static/a7e6a5aba590d4933e35eaadabd97fd2_44e00e968ac57725a15b32f9ca714827aff8e4818d290cb0c611f2e2585253b3"

  # example with all options
  person_request = FcEnrich::PersonEnrichRequest.new(
    emails: ["bart@fullcontact.com", "bart.lorang@fullcontact.com"],
    phones: ["+17202227799", "+13035551234"],
    location: { "address_line1": "123 Main Street",
                "address_line2": "Unit 2",
                "city": "Denver",
                "region": "Colorado",
                "region_code": "CO",
                "postal_code": "80203" },
    name: { "full": "Bart Lorang",
            "given": "Bart",
            "family": "Lorang" },
    profiles: [{ "service": "twitter", "username": "bartlorang" },
               { "service": "twitter", "userid": "5998422" },
               { "service": "linkedin", "url": "https://www.linkedin.com/in/bartlorang" },
               { "service": "github", "url": "https://www.github.com/lorangb"}],
    maids: ["ape2ch30-pifn-cbvi-30yy-nia-zex7aw5u"],
    person_id: "eYxWc0B-dKRxerTw_uQpxCssM_GyPaLErj0Eu3y2FrU6py1J",
    record_id: "customer123",
    infer: true,
    data_filter: ["social", "employment_history"])
```


#### Company Enrich

see https://platform.fullcontact.com/docs/apis/enrich/company-enrichment

```ruby
  company_request = FcEnrich::CompanyEnrichRequest.new(domain: "fullcontact.com")
  company = company_request.perform
  puts company.name # "FullContact, Inc."
  puts company.location # "1755 Blake Street, Suite 450, Denver, Colorado, United States"
  puts company.twitter # "@fullcontact"
  puts company.linkedin # "https://www.linkedin.com/company/fullcontact-inc-"
  puts company.bio # "FullContact is the ... contacts and be awesome with people."
  puts company.logo # "https://d2ojpxxtu63wzl.cloudfront.net/stati...8ea9e4d47f5af6c"
  puts company.website # "https://www.fullcontact.com"
  puts company.founded # 2010
  puts company.employees # 350
  puts company.locale # "en"
  puts company.category # "Other"
  puts company.details # ...
```

### Testing

Inside your tests can enable fake mode which will always return the same sample json

```ruby
Rspec.describe "Test" do
  before :each do
    allow(FcEnrich).to receive(:use_fake?).and_return(true)
  end

  it 'returns sample person info' do
    person_request = FcEnrich::PersonEnrichRequest.new(email: "any@email.com")
    person = person_request.perform
    expect(person.full_name).to eq("Bart Lorang")
  end

  it 'returns sample company info' do
    allow(described_class).to receive(:use_fake?).and_return(true)

    person_request = FcEnrich::CompanyEnrichRequest.new(domain: "email.com")
    person = person_request.perform
    expect(person.name).to eq("FullContact, Inc.")
  end
end
```

there is an option to enable fake mode all the time

```ruby
  FcEnrich.use_fake

  # allows you to set a folder where fake data is pulled from
  # this will created the folder with examples in it
  FcEnrich::FakeClient.folder = "data/fc_enrich"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


