class FilmsController < ApplicationController
  before_action :find_film, only: :show

  def show
    @rate = @film.ratings.build

    if params[:id_review]
      @review = Review.find_by id: params[:id_review]
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def find_film
    @film = Film.find_by id: params[:id]
  end
end
