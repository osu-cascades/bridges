source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'acts-as-taggable-on'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.4.1'
gem 'bootstrap4-datetime-picker-rails'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'font-awesome-rails'
gem 'haml'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg'
gem 'puma', '~> 4.3.9'
gem 'rails', '~> 5.2.4.6'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sassc-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 4.3.0'
  gem 'simplecov', require: false
end

group :production do
  gem 'airbrake', '~> 10.0.3'
end
