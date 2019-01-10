source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'duktape'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant for image hosting
gem 'mini_magick', '~> 4.8'
gem 'carrierwave-aws'
gem 'aws-sdk-rails'
gem 'figaro'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Create pretty URL’s and work with human-friendly strings
gem 'friendly_id', '~> 5.2.4'

# Use Bootstrap and JQuery and Popper for SCSS/CSS and Javascipt framework
gem 'bootstrap', '~> 4.1.3'
gem 'jquery-rails', '4.3.1'
gem 'jquery-ui-rails'
gem 'jquery-atwho-rails'
gem 'popper_js', '~> 1.14.3'

# Use Font Awesome for Icons
gem 'font-awesome-sass', '~> 5.3.1'

# Use Faker for testing
gem 'faker', '1.9.1'

# Abort requests that are taking too long; an exception is raised
gem "rack-timeout"

# Validates overlap of time slots
gem 'validates_overlap'

group :development, :test do
	# Use sqlite3 as the database for Active Record
	gem 'sqlite3', git: "https://github.com/larskanis/sqlite3-ruby", branch: "add-gemspec"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '3.1.5'
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper', '1.2.0'
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'win32console'
end

group :production do
	gem 'pg', '0.20.0'	
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
