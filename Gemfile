source "https://rubygems.org"

ruby "4.0.5"

gem "rails", "~> 8.1.3"
gem "pg", "~> 1.6"
gem "puma", ">= 5.0"

gem "grape", "~> 3.2"
gem "grape-entity", "~> 1.1"
gem "grape-swagger", "~> 2.1"
gem "grape-swagger-entity", "~> 0.7"

gem "trailblazer", "~> 2.1"

gem "bcrypt", "~> 3.1"
gem "jwt", "~> 3.2"

gem "tzinfo-data"
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
  gem "factory_bot_rails"
end
