source "https://rubygems.org"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem "rails", "~> 5.1.4"
gem "bcrypt", "3.1.11"
gem "faker",  "1.7.3"
gem "carrierwave", "1.1.0"
gem "mini_magick", "4.7.0"
gem "fog", "1.40.0"
gem "config"
gem "config"
gem "bootstrap-sass", "3.3.7"
gem "jquery-turbolinks"
gem "jquery"
gem "jquery-rails"
gem "font-awesome-rails"
gem "puma", "~> 3.7"
gem "devise"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "pry-byebug"
gem "bootstrap-datepicker-rails"
gem "cancancan", "~> 2.0"
gem "carrierwave", "1.1.0"
gem "mini_magick", "4.7.0"
gem "simple_form"
gem "kaminari"
gem "smart_listing"
gem "cocoon"
gem "social-share-button", github: "huacnlee/social-share-button"
group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "rspec-rails", "~> 3.5"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "pry"
end
group :development do
  gem "mysql2"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
group :production do
  gem "rails_12factor"
end
group :test do
  gem "rspec-activemodel-mocks"
  gem "database_cleaner"
  gem "shoulda-matchers", "3.0.1"
  gem "simplecov"
  gem "rails-controller-testing"
  gem "simplecov", require: false
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
