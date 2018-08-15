class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :film

  after_save :update_average_ratings

  private

  def update_average_ratings
    average_ratings = self.film.ratings.collect(&:rate).sum / self.film.ratings.count.to_f
    film.update_attributes average_ratings: average_ratings
  end
end
