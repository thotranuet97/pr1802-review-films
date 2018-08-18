class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:email]&.downcase
    if user&.authenticate params[:password]
      log_in user
      "1" == params[:remember_me] ? remember(user) : forget(user)
      redirect_back_or root_url
    else
      flash.now[:danger] = t ".invalid_email_password"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, flash: {info: t(".logout_success")}
  end
end
