class User < ApplicationRecord
  has_many :films
  has_many :comments
  has_many :rattings
  has_many :films, through: :rattings
  has_many :reviews
end
