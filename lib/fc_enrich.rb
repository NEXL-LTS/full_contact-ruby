require "fc_enrich/version"

module FcEnrich
  class Error < StandardError; end
  # Your code goes here...

  class BadRequest < StandardError
    attr_reader :status, :message

    def initialize(response)
      client_response = JSON.parse(response)
      @status = client_response['status']
      @message = client_response['message']
      super
    end
  end

  def self.api_key=(val)
    @key = val.to_str
  end

  def self.api_key
    @key
  end

  def self.http_client
    use_fake? ? FakeClient.new : HttpClient.new
  end

  def self.use_fake
    @use_fake = true
  end

  def self.use_fake?
    @use_fake
  end
end

require 'fc_enrich/person_enrich_request'
require 'fc_enrich/company_enrich_request'
require 'fc_enrich/fake_client'
