require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bday
  class Application < Rails::Application
    config.force_ssl = true
    config.time_zone = 'Asia/Seoul'
    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'ALLOW-FROM https://www.facebook.com'
    }
    config.assets.precompile += [
      'application.js', 'application.css', 
      'admin.js', 'admin.css', 
      'web.css', 'web.js',
      'mobile.css', 'mobile.js',
      'facebook.css', 'facebook.js'
    ]
  end
end
