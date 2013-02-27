source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '>= 3.2.12'

gem 'nokogiri'
gem 'typhoeus'
gem 'bootstrap-sass'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'

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
