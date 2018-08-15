class Hashtag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :reviews, through: :taggings, dependent: :destroy
end
