require_relative 'lib/full_contact/version'

Gem::Specification.new do |spec|
  spec.name          = "full_contact"
  spec.version       = FullContact::VERSION
  spec.authors       = ["Grant Petersen-Speelman"]
  spec.email         = ["grant@nexl.io"]
  spec.license       = "MIT"

  spec.summary       = %q{A ruby client to interact with Full contact API}
  spec.description   = %q{A ruby client to interact with Full contact API}
  spec.homepage      = "https://github.com/NEXL-LTS/full_contact-ruby"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/NEXL-LTS/full_contact-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/NEXL-LTS/full_contact-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.add_dependency 'activesupport'
  spec.add_dependency 'hashie'
  spec.add_dependency 'multi_json'
  spec.add_dependency 'rest-client'
end