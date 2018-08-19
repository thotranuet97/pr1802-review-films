class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    @films = @category.films
      .paginate page: params[:page], per_page: 10    

    if params[:search_params].present?
      @films = @films.search_in_cat params[:search_params]
    end

    @sort_prams = Category::SORT_PARAMS
    if params[:sort_params].present?
      @films = @films.sort_films params[:sort_params]
    end

    @release_years_list = Film.release_years_list.map &:release_date
    if params[:year_params].present?
      @films = @films.filter_by_year params[:year_params]
    end

    @directors_list = Film.directors_list.map &:directors
    if params[:director_params].present?
      @films = @films.filter_by_director params[:director_params]
    end

    if params[:start_date].present? && params[:end_date].present?
      @films = @films.filter_by_interval params[:start_date],
        params[:end_date]
    end
  end

  def index
    @categories = Category.all
  end
end
