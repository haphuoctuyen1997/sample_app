class SessionsController < ApplicationController
  def new; end

  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase
    if user && user.authenticate(session[:password])
      if user.activated?
        remembe_me user, params
        redirect_back_or user
      else
        message = t "users.create.message"
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = t "users.create.invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def remembe_me user, params
    session_me = params[:session][:remember_me]
    log_in user
    session_me == Settings.remember_me ? remember(user) : forget(user)
  end
end
