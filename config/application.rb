require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mishalandsamuel
  class Application < Rails::Application

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # removes timestamp from migration files
    config.active_record.timestamped_migrations = false
    # Add fonts to the assets pipeline
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # setup ActionMailer
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      user_name: 'username',
      password: 'password',
      authentication: 'plain',
      enable_starttls_auto: true
    }
  end
end
