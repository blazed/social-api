source 'https://rubygems.org'


gem 'rails', '4.2.1'
gem 'pg'
gem 'rails-api'

gem 'active_model_serializers'
gem 'oj'
gem 'oj_mimic_json'

gem 'devise'

gem 'sidekiq'
gem 'sinatra', require: nil
gem 'hiredis'
gem 'redis', require: ['redis', 'redis/connection/hiredis']

gem 'seed-fu'
gem 'friendly_id'
gem 'paperclip'
gem 'aws-sdk', '<= 2.0'

gem 'rack-cors', require: 'rack/cors'

gem 'open_graph_reader'
gem 'faraday'
gem 'faraday_middleware'
gem 'faraday-cookie_jar'
gem 'twitter-text'

gem 'kaminari'

gem 'settingslogic'

# Realtime
gem 'pusher'

# PgStats
gem 'pghero'

group :development do
  gem 'annotate'
  gem 'thin'
  gem 'foreman', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rerun'
  #gem 'letter_opener'
  gem 'pry-rails'
  gem 'guard-rspec', require: false

  # Deployment stuff
  gem 'capistrano', '~> 3.4'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler'
  gem 'capistrano-sidekiq'
  gem 'capistrano-pumaio', require: false
end

group :development, :test do
  gem 'faker'
  gem 'rspec', '~>3.2'
  gem 'fabrication', '~> 2.13'
  gem 'mocha', require: false
  gem 'rspec-rails'
  gem 'shoulda', require: false
  gem 'rspec-given'
  gem 'webmock', require: false
  gem 'spork'
  gem 'pry-nav'
  gem 'fakes3'
  gem 'pry-byebug'
  gem 'byebug'
  gem 'web-console', '~> 2.1'
  gem 'spring'
  gem 'pusher-fake'
end

group :test do
  gem 'simplecov', require: false
end


gem 'puma'
