class Film < ApplicationRecord
  belongs_to :user
  has_one :review
  has_many :ratings
  has_many :raters, class_name: User.name, through: :ratings
  has_many :film_categories
  has_many :categories, through: :film_categories
end
