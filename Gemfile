source "https://rubygems.org"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem "rails", "~> 5.1.4"
gem "bcrypt", "3.1.11"
gem "faker"
gem "carrierwave", "1.1.0"
gem "mini_magick", "4.7.0"
gem "fog", "1.40.0"
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
gem "pdfkit"
gem "wkhtmltopdf-binary"
gem "validates_serialized"
gem "ckeditor"
gem "figaro"
gem "activerecord-import"
gem "ransack"
gem "sidekiq"
gem "gon"
gem "jquery-turbolinks"
gem "public_activity"
gem "rubocop", "~> 0.49.1", require: false
gem "jquery-validation-rails"
gem "chartkick"
gem "i18n-js"
gem "paranoia"
gem "fancybox-rails"
gem "highcharts-rails"
gem "groupdate", github: "ankane/groupdate", branch: "debug_time_zone_support"
gem "delayed_job_active_record"
gem "redis"
gem "gmail"
gem 'omniauth-oauth2', '~> 1.3.1'
gem 'omniauth-google-oauth2'
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
  gem "rack-cors", require: "rack/cors"
  gem "rack-mini-profiler",  require: false
  gem "bullet"
end
group :production do
  gem "rails_12factor"
end
group :test do
  gem "rspec-activemodel-mocks"
  gem "database_cleaner"
  gem "shoulda-matchers", "~> 3.1", ">= 3.1.2"
  gem "simplecov"
  gem "rails-controller-testing"
  gem "simplecov", require: false
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
