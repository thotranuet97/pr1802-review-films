class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    @films = @category.films
    @sort_prams = I18n.translate :options
    @release_years_list = Film.release_years_list.map &:release_date
    @directors_list = Film.directors_list.map &:directors

    @films = @films.filter params

    @films = @films.paginate page: params[:page],
      per_page: Settings.films.per_page
  end

  def index
    @categories = Category.all
  end
end
