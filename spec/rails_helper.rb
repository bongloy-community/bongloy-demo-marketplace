require "spec_helper"
require "support/controller_helpers"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require 'webmock/rspec'
require 'webdrivers'

Dir[Rails.root.join("spec", "support", "**", "*.rb")].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::Test::IntegrationHelpers
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Capybara::DSL
  config.include Warden::Test::Helpers
  config.include ControllerHelpers, type: :controller
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

   #Capybara.javascript_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome_headless

  allowed_sites = [
    "https://chromedriver.storage.googleapis.com",
    "https://github.com/mozilla/geckodriver/releases",
    "https://selenium-release.storage.googleapis.com",
    "https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver"
  ]

  WebMock.disable_net_connect!(allow_localhost: true, allow: allowed_sites)

  VCR.configure do |config|
    config.ignore_hosts(
      "chromedriver.storage.googleapis.com",
      "github.com/mozilla/geckodriver/releases",
      "selenium-release.storage.googleapis.com",
      "developer.microsoft.com/en-us/microsoft-edge/tools/webdriver"
    )
  end
end
