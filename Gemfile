source 'https://rubygems.org'

ruby '2.1.6'

gem 'rails', '~> 4.1.11'

gem 'nokogiri'
gem 'typhoeus'
gem 'bootstrap-sass'
gem 'exception_notification', '>= 4.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm'
  gem 'rails_12factor' # For Heroku (logging and assets), see https://devcenter.heroku.com/articles/rails4
end

group :development, :test do
  gem 'rspec-rails'
  gem 'vcr'
end
