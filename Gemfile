source 'https://rubygems.org'

ruby '2.2.4'

gem 'rails', '~> 4.2.4'

gem 'nokogiri', '>= 1.6.6.4'
gem 'bootstrap-sass'
gem 'exception_notification', '>= 4.0'

gem 'itunes-search-api',
  :git => 'https://github.com/mocoso/itunes-search-api.git',
  :branch => 'use-http-client'
gem 'google_play_search', '>= 0.0.17',
  :git => 'https://github.com/mocoso/google_play_search.git',
  :branch => 'use-net-http'

gem 'blinkbox_films',
  :git => 'https://github.com/mocoso/blinkbox_films.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 2.7.2'
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm'
  gem 'rails_12factor' # For Heroku (logging and assets), see https://devcenter.heroku.com/articles/rails4
end

group :development, :test do
  gem 'rspec-rails'
end
