require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings.
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Enable caching
  config.action_controller.perform_caching = true

  # Serve static files if Heroku tells Rails to do so
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Cache assets for far-future expiry
  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  config.active_storage.service = :cloudflare_r2

  # ============================
  # SSL / Security
  # ============================
  config.force_ssl = true

  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Silence health check noise
  config.silence_healthcheck_path = "/up"

  config.active_job.queue_adapter = :sidekiq

  config.cache_store = :memory_store

  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = {
    host: ENV["APP_HOST"]
  }

  config.i18n.fallbacks = true

  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]

  config.hosts << ".herokuapp.com"
end
