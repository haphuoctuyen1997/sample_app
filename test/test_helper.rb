ENV["RAILS_ENV"] ||= "test"
require File.expand_path "../../config/environment"
require "rails/test_help"
class ActiveSupport::TestCase
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].present?
  end

  def log_in_as user
    session[:user_id] = user.id
  end
end
class ActionDispatch::IntegrationTest
  def log_in_as user, password: "password", remember_me: "1"
    post login_path, params: {session: {email: user.email,
                                        password: password,
                                        emember_me: remember_me}}
  end
end
