source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '>= 4.0.0'

gem 'nokogiri'
gem 'typhoeus'
gem 'bootstrap-sass'
gem 'exception_notification', :git => 'git://github.com/smartinez87/exception_notification.git' # Because it includes 4.0 fixes which are not in a release gem yet

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'vcr'
end
