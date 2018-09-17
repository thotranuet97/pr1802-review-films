class ReviewsController < ApplicationController
  before_action :find_review, only: :show

  def index
    @reviews = Review.paginate page: params[:page],
      per_page: Settings.reviews.per_page
  end

  def show
  end

  private

  def find_review
    film = Film.find_by_id params[:film_id]
    @review = film.review
  end
end
