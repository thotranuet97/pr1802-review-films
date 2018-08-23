class ReviewsController < ApplicationController
  before_action :find_review, only: :show

  def show
    @comments = @review.comments
  end

  private

  def find_review
    @review = Review.find_by id: params[:id]
  end
end
