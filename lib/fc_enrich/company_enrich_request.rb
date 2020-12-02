require 'hashie'
require 'active_support/core_ext/string'

require_relative 'http_client'

module FcEnrich
  class CompanyEnrichRequest < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess

    property :domain
    property :webhookUrl, from: :webhook_url

    def perform(http_client: FcEnrich.http_client)
      Response.new(
        http_client.post("/v3/company.enrich", to_hash)
      )
    end

    class Response < Hashie::Trash
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::IgnoreUndeclared
      include Hashie::Extensions::Coercion

      property :name
      property :location
      property :twitter
      property :linkedin
      property :bio
      property :logo
      property :website
      property :founded
      property :employees
      property :locale
      property :category
      property :details

      coerce_key :details, Hashie::Mash
    end
  end
end
