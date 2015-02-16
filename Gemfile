source 'https://rubygems.org'
ruby '2.2.0'

# Use dotenv to manage secrets and other environment variables
gem 'dotenv-rails', group: :development

### BACKEND ###

# Use Rails as the framework
gem 'rails', '4.2.0'
# Use ActiveModel::Serializer (specificallly this version)
gem 'active_model_serializers', '0.9.1'
# Use PostgreSQL as the database
gem 'pg'
# Use Thin as the app server
gem 'thin'
# Use layouts and stylesheets for email templates
gem 'premailer-rails'
gem 'nokogiri'


### ASSETS ###

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use Ember as the client-side MVC
gem 'ember-rails'
gem 'ember-source', '~> 1.9.1'
# Use Font Awesome icons
gem 'font-awesome-rails'


### DEVELOPMENT ###

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Use Letter Opener to preview emails in the browser
  gem 'letter_opener'
end


### PRODUCTION ###

group :production do
  # Use for heroku
  gem 'rails_12factor'
end
