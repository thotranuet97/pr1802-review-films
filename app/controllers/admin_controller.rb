class AdminController < ApplicationController
  before_action :logged_in_user
  before_action :authenticated_user!
  layout "admin"

  private
  def authenticated_user!
    return if current_user.admin?
    redirect_to root_url, flash: {danger: t("admin.unauthorized")}
  end
end
