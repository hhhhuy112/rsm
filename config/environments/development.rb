Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # if Rails.root.join('tmp/caching-dev.txt').exist?
  config.action_controller.perform_caching = true

    # config.cache_store = :file_store, Rails.root.join('tmp/caching-dev.txt')
    # config.public_file_server.headers = {
    #   "Cache-Control" => "public, max-age=#{2.days.seconds.to_i}"
    # }

  # cache_servers = "redis://localhost:3000/0/cache"
  # config.cache_store = :redis_cache_store, { url: cache_servers,

  #   connect_timeout: 30,  # Defaults to 20 seconds
  #   read_timeout:    0.2, # Defaults to 1 second
  #   write_timeout:   0.2, # Defaults to 1 second

  #   error_handler: -> (method:, returning:, exception:) {
  #     # Report errors to Sentry as warnings
  #     Raven.capture_exception exception, level: 'warning',
  #     tags: { method: method, returning: returning }
  #   }
  # }

  cache_servers = ENV["redis_url"]
  config.cache_store = :redis_cache_store, { url: cache_servers, expires_in: 60.minutes }

  # config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
  # else
  #   config.action_controller.perform_caching = false

  #   config.cache_store = :null_store
  # end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = {host: "localhost", port: 3000}
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    authentication: "plain",
    user_name: ENV["username"],
    password: ENV["password"],
    domain: "localhost:3000",
    enable_starttls_auto: true
  }
  config.action_mailer.asset_host = "http://localhost:3000"
  config.action_controller.asset_host = "http://localhost:3000"
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  # config.active_job.queue_adapter = :delayed_job
  config.active_job.queue_adapter = :sidekiq
  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end
end
