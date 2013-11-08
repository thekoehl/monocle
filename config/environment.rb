# Load the Rails application.
require File.expand_path('../application', __FILE__)

config_file = Rails.root.join('config', 'app_config.yml')
APP_CONFIG = YAML.load_file(config_file)[Rails.env] if File.exists?(config_file)

# Initialize the Rails application.
PDMonocle::Application.initialize!
