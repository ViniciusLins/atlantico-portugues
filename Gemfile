source 'https://rubygems.org'

# Freeze the ruby version 
ruby '2.2.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
    # Use sqlite3 as the database for Active Record
    # gem 'sqlite3', '1.3.10'

    gem 'pg'

    gem 'rspec-rails', '2.9.0'
    # Needed by rspec-rails works properly
    gem 'test-unit'

    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', '3.5.1'

    # Access an IRB console on exception pages or by using <%= console %> in views
    gem 'web-console', '2.0.0'

    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring', '1.3.1'
end

group :assets do
    # Use SCSS for stylesheets
    gem 'sass-rails', '5.0.0'
    # Use Uglifier as compressor for JavaScript assets
    gem 'uglifier', '2.7.0'
    # Use CoffeeScript for .coffee assets and views
    gem 'coffee-rails', '4.1.0'
    # See https://github.com/sstephenson/execjs#readme for more supported runtimes
    # gem 'therubyracer', platforms: :ruby
end

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.0.3'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.5.3'
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
end

#group :prodUction do
#    gem 'pg'
#end
