source 'https://rubygems.org'

gem 'rails', '~>4.2'
gem 'rake', '< 11.0'
gem 'puma'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  # gem 'pg', '~> 0.20'
  gem 'mysql2', '~> 0.4.0'
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'minitest'

  gem 'sqlite3'

  # возможно последующие два должны быть лишь в группе тест, нет времени проверять
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
end

gem 'bcrypt-ruby', '3.1.2'

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

group :development do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-chruby'
  gem 'capistrano3-puma'
  # gem 'capistrano-sidekiq'
  gem 'capistrano-npm'
end

# To use debugger
# gem 'debugger'
