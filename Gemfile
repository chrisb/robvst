source 'https://rubygems.org'

gem 'rails', '~> 4.0'
gem 'activerecord-session_store'

# Auth/users
gem 'devise'
gem 'bcrypt-ruby', '~> 3.0.0'

# Frontend Utilities
gem 'slim', '~> 1.2'
gem 'turbolinks', '~> 1.0'
gem 'jquery-rails', '~> 2'
gem 'compass-rails', '~> 2.0.alpha.0'

gem 'carrierwave'
gem 'mini_magick'

# Markdown
gem 'kramdown', '~> 1.0', require: false
gem 'coderay', '~> 1.0'

# Pagination
gem 'kaminari', '~> 0.14'

# Date/URL Utilities
gem 'chronic', '~> 0.8'
gem 'stringex', '~> 2', github: 'rsl/stringex'

gem 'libv8' #, '~>3.16'
gem 'therubyracer', `hostname`.include?('shadow.io') ? '0.11.3' : { github: 'cowboyd/therubyracer' }  # If using Ruby

platform :jruby do
  gem 'trinidad'
  gem 'activerecord-jdbcpostgresql-adapter'
end

platform :ruby do
  gem 'pg', '~> 0.14'
  gem 'unicorn'
end

group :production do
  gem 'aws-sdk', '~> 1.3.4'
end

group :development, :test do
  gem 'sqlite3', '~> 1', platform: [:ruby, :mswin, :mingw]
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'capistrano-unicorn'
  gem 'quiet_assets'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'rb-fsevent', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end
