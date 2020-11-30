require "full_contact/version"

module FullContact
  class Error < StandardError; end
  # Your code goes here...

  def self.api_key=(val)
    @key = val.to_str
  end

  def self.api_key
    @key
  end
end

require 'full_contact/person_enrich_request'
