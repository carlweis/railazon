ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    session[:user_id] = users(user).id
  end

  def logout
    session.delete :user_id
  end

  def setup
    login_as :one if defined? session
  end
end
