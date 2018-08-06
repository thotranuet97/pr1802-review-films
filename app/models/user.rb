class User < ApplicationRecord
  has_many :films
  has_many :comments
  has_many :ratings
  has_many :rated_films, class_name: Film.name, through: :ratings
  has_many :reviews
end
