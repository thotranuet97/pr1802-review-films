class Hashtag < ApplicationRecord
  has_many :taggings
  has_many :reviews, through: :taggings
end
