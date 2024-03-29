require 'hashie'
require 'active_support/core_ext/string/inflections'

require_relative 'http_client'

module FcEnrich
  class PersonEnrichRequest < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess

    property :email
    property :emails
    property :phone
    property :phones
    property :location,
             transform_with: ->(v) { v.transform_keys! { |key| key.to_s.camelize(:lower) } }
    property :name
    property :profiles
    property :maids
    property :personId, from: :person_id
    property :recordId, from: :record_id
    property :dataFilter, from: :data_filter
    property :infer

    def perform(http_client: FcEnrich.http_client)
      Response.new(
        http_client.post("/v3/person.enrich", to_hash)
      )
    end

    class Response < Hashie::Trash
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::IgnoreUndeclared
      include Hashie::Extensions::Coercion

      property :full_name, from: :fullName
      property :age_range, from: :ageRange
      property :gender
      property :location
      property :title
      property :organization
      property :twitter
      property :linkedin
      property :facebook
      property :bio
      property :avatar
      property :details

      coerce_key :details, Hashie::Mash
    end
  end
end
