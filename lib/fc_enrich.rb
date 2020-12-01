require "fc_enrich/version"

module FcEnrich
  class Error < StandardError; end
  # Your code goes here...

  def self.api_key=(val)
    @key = val.to_str
  end

  def self.api_key
    @key
  end
end

require 'fc_enrich/person_enrich_request'
