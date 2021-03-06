source "https://rubygems.org"

# Specify your gem's dependencies in snov.gemspec
gemspec

gem "rake", "~> 12.0"
gem "rspec", "~> 3.0"
gem "rubocop"
gem "rubocop-rspec"
gem "simplecov"
gem "webmock"

if ENV['GEM_VERSIONS'] == 'min'
  gem 'activesupport', '~> 3.2.0'
  gem 'hashie', '~> 3.1.0'
  gem 'multi_json', '~> 1.0.0'
  gem 'rest-client', '~> 2.0.0'
end
