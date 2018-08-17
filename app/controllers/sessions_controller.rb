class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      remembe_me user
      redirect_to user
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

  def remembe_me user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
