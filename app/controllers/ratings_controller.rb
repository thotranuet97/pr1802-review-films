class RatingsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :find_rate, only: :update

  def create
    @rate = Rating.new rate_params
    if @rate.save
      flash[:success] = t ".rating_created"
      redirect_to film_path @rate.film_id
    else
      flash[:danger] = t ".rating_created_error"
      render "films/show"
    end
  end

  def update
    if @rate.update_attributes rate_params
      flash[:success] = t ".rating_updated"
      redirect_to film_path @rate.film_id
    else
      flash[:danger] = t ".rating_updated_error"
      render "films/show"
    end
  end

  private

  def rate_params
    params.require(:rating).permit(:rate, :film_id).merge user_id: current_user.id
  end

  def find_rate
    @rate = current_user.ratings.find_by id: params[:id]
  end
end
