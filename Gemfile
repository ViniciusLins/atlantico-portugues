source 'https://rubygems.org'

# Freeze the ruby version 
ruby '2.1.5'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'


# This gem is a used for encrypt password of user, by has_secure_password pattern
gem 'bcrypt-ruby', '3.1.2'

# Faker gem allow us, fill database with some users
gem 'faker', '1.4.3'
# Database postgres
gem 'pg', '0.18.1'

# web server
gem 'thin'

# ------------------------------------
# INTERFACE GEMS
# -----------------------------------
# Twitter bootstrap gem
gem 'bootstrap-sass', '3.0.0'
# Will paginate, enable pagination data
gem 'will_paginate-bootstrap', '1.0.1'

# Bootsy is a WYSWIG EDITOR
gem 'bootsy', '2.1.0'

# Handle upload documents
gem 'paperclip', '~> 4.2'

gem 'pdfjs_rails', '0.0.1'

gem 'gaffe'
# ------------------------------------
# UTILITY GEMS # -----------------------------------

# Sunspot is advanced search gem
gem 'sunspot_rails', '~> 2.2'
gem 'sunspot_solr', '~> 2.2'

# Rails erd gem to generate model ER
gem 'rails-erd', '1.3.1'



group :development, :test do
    # Use sqlite3 as the database for Active Record
    # gem 'sqlite3', '1.3.10'

    gem 'rspec-rails', '2.9.0'
    # Needed by rspec-rails works properly
    gem 'test-unit'

    gem 'guard-spork', '0.3.2'
    # Guard is a Gem for monitoring files changed
    gem 'guard', '2.2.4'
    gem 'guard-rspec', '0.5.5'
    # Change spork gem by this because spork gem not support rails 4
    gem 'spork-rails', '4.0.0'  


    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', '3.5.1'

    # Access an IRB console on exception pages or by using <%= console %> in views
    gem 'web-console', '2.0.0'

    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring', '~> 1.3'

    gem 'annotate', '~> 2.4.1.beta'
    # Deployment 
    gem 'capistrano', '~> 3.0'
    gem 'capistrano-rails'
    gem 'capistrano-rvm'
    gem 'capistrano-bundler'
end

group :assets do
    # Use SCSS for stylesheets
    gem 'sass-rails', '4.0.2'
    # Use Uglifier as compressor for JavaScript assets
    gem 'uglifier', '2.7.0'
    # Use CoffeeScript for .coffee assets and views
    gem 'coffee-rails', '4.1.0'
    # See https://github.com/sstephenson/execjs#readme for more supported runtimes
    gem 'therubyracer', platforms: :ruby
end

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.1.2'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '2.5.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.2.6'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '0.4.1', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

group :test do
    gem 'capybara', '1.1.2'
    gem 'rb-inotify', '~> 0.9'
    gem 'factory_girl_rails', '~> 4.5.0'
    gem 'database_cleaner', '1.4.1'
    # Commented this gem for guard use just tmux notification
    # gem 'libnotify', '0.5.9'
    # gem 'spork', '0.9.0'
end

group :production do
  # Need add this gem to asset pipeline works as expected in heroku server
  # gem 'rails_12factor'
end

gem 'passenger', '5.0.6'
