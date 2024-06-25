ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# test/test_helper.rb
class ActiveSupport::TestCase
  # [...]

  # Devise test helpers
  include Warden::Test::Helpers
  Warden.test_mode!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :users, :festivals, :love_pods, :festival_love_pods
end

# Folder path for screenshots
Capybara.save_path = Rails.root.join("tmp/capybara")
