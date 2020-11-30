RSpec.describe FullContact do
  it "has a version number" do
    expect(FullContact::VERSION).not_to be nil
  end

  it 'can set api key' do
    described_class.api_key = "TEST!"

    expect(described_class).to have_attributes(api_key: "TEST!")
  end
end
