source "https://rubygems.org"

gem "bootsnap", require: false
gem "cssbundling-rails"
gem "devise", "~> 4.9"
gem "image_processing", "~> 1.2"
gem "jbuilder"
gem "jsbundling-rails"
gem "puma", ">= 5.0"
gem "pundit"
gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 4.3"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "error_highlight", ">= 0.4.0", platforms: [ :ruby ]
  gem "letter_opener"
  gem "letter_opener_web"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end