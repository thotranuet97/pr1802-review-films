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

    @film_relateds = Film.related_films(@film).order_created_desc
  end

  def index
    @films = Film.all
    if params[:search_content].present?
      if I18n.translate(:options).include? params[:search_option]
        @films = @films.search_with_option params[:search_option], params[:search_content]
      else
        @films = @films.search_all params[:search_content]
      end
    end
    @films = @films.order_released_desc.paginate page: params[:page],
      per_page: Settings.films.per_page
  end

  private

  def find_film
    @film = Film.find_by id: params[:id]
  end
end
