require "full_contact_api/version"

module FullContactApi
  class Error < StandardError; end
  # Your code goes here...

  def self.api_key=(val)
    @key = val.to_str
  end

  def self.api_key
    @key
  end
end

require 'full_contact_api/person_enrich_request'
