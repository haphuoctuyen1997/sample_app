class SessionsController < ApplicationController
  def new; end

  def create
    return render_login_page if params[:session].blank?

    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      render_login_page
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def render_login_page
    flash.now[:danger] = t "users.create.invalid"
    render :new
  end
end
