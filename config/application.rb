require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuración para la sesión
    config.session_store :cookie_store, key: '_blog_session'
  end
end
