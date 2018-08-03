class PagesController < ApplicationController
  def home
  end

  def admin
    render layout: "admin"
  end
end
