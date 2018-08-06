class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, NoMethodError, with: :not_found?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def not_found?
    render file: "#{Rails.root}/public/404.html", status: 403, layout: false
  end

  private
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "users.create.log_in"
    redirect_to login_path
  end
end
