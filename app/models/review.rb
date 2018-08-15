class Review < ApplicationRecord
  belongs_to :user
  belongs_to :film
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :hashtag, through: :taggings, dependent: :destroy

  mount_uploader :banner, ThumbnailUploader
  mount_uploader :thumbnail, ThumbnailUploader
end
