require 'fileutils'

module FcEnrich
  class FakeClient
    def self.folder=(val)
      @folder = val
      FileUtils.mkdir_p(@folder)
      FileUtils.cp_r "#{default_folder}/post_v3_company.enrich", @folder
      FileUtils.cp_r "#{default_folder}/post_v3_person.enrich", @folder
    end

    def self.folder
      @folder || default_folder
    end

    def self.reset_folder
      @folder = nil
    end

    def self.default_folder
      "#{__dir__}/fake_client"
    end

    def post(path, payload_hash)
      add = payload_hash.to_a.map { |v| v.join("=") }.join("&").tr(".", "_")
      data = File.read("#{self.class.folder}/post#{path.tr("/", "_")}/#{add}.json")
      MultiJson.load(data)
    rescue Errno::ENOENT
      nil
    end
  end
end
