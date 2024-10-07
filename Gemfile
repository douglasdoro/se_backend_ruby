# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'blueprinter'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'redis-rails'
# gem "redis", ">= 4.0.1"
# gem "kredis"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'bootsnap', require: false
gem 'foreman'
gem 'rack-cors'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sidekiq'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]

  gem 'database_cleaner-active_record'

  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'rswag-specs'

  gem 'factory_bot_rails'
  gem 'factory_trace'
  gem 'faker'

  gem 'shoulda-matchers'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
end
