require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Delta
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    credentials.config.each do |key, value|
      if key.to_s == Rails.env
        value.each do |env_key, env_value|
          ENV[env_key.to_s.upcase] = env_value.to_s if ENV[env_key.to_s.upcase].blank?
          ENV[env_key.to_s.downcase] = env_value.to_s if ENV[env_key.to_s.downcase].blank?
        end
      elsif ['development', 'staging', 'test', 'production'].include?(key.to_s) == false
        ENV[key.to_s.upcase] = value.to_s if ENV[key.to_s.upcase].blank?
        ENV[key.to_s.downcase] = value.to_s if ENV[key.to_s.downcase].blank?
      end
    end
  end
end
