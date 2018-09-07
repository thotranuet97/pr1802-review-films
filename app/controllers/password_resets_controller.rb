class PasswordResetsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by email: params[:email].downcase
    user&.send_password_reset
    flash[:info] = t ".email_sent_if_valid"
    redirect_to root_url
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t(".cant_be_empty")
      render :edit
    elsif @user.update user_params
      @user.update reset_token: nil
      redirect_to root_url, notice: t(".password_has_been_reset")
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:user_id]
    return if @user&.authenticated? :reset, params[:id]
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t ".password_reset_expired"
    redirect_to new_password_reset_url
  end
end
