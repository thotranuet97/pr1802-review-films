class Review < ApplicationRecord
  belongs_to :user
  belongs_to :film
  has_many :comments
  has_many :taggings
  has_many :hashtag, through: :taggings
end
