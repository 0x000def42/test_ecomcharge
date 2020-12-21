source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'pg'
gem 'ruby-progressbar'
gem 'unicorn'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'faker'
end

group :test do
  gem 'rest-client'
  gem 'rspec-benchmark'
  gem 'factory_bot'
  gem 'rspec'
  gem 'capybara'
  gem 'database_cleaner-sequel'
end

group :production do
  # gem 'puma'
end
