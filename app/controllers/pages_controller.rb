class PagesController < ApplicationController
  def home
    @films = Film.all
    @slider_films = @films.order_created_desc

    @this_month_films = @films.this_month
    
    temp = @this_month_films.pluck :id
    @this_month_reviews = Review.find_by_film_ids temp
  end
end
