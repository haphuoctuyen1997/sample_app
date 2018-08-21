require "test_helper"

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "password resets" do
    invalidemail
    validemail
    user = assigns(:user)
    inactive user
    patch password_reset_path(user.reset_token),
      params: {email: user.email, user: {password: "foobaz",
                                         password_confirmation: "barquux"}}
    assert_select "div#error_explanation"
    patch password_reset_path(user.reset_token),
      params: {email: user.email, user: {password: "",
                                         password_confirmation: ""}}
    assert_select "div#error_explanation"
    patch password_reset_path(user.reset_token),
      params: {email: user.email, user: {password: "foobaz",
                                         password_confirmation: "foobaz"}}
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
