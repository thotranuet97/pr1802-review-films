class Category < ApplicationRecord
  SORT_PARAMS_FOR_SELECT = %w(name release_date)
  has_many :film_categories, dependent: :destroy
  has_many :films, through: :film_categories, dependent: :destroy
end
