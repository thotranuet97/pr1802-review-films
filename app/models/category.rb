class Category < ApplicationRecord
  SORT_PARAMS = %w(name release_date)
  has_many :film_categories, dependent: :destroy
  has_many :films, through: :film_categories, dependent: :destroy
end
