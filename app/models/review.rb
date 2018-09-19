class Review < ApplicationRecord
  include Nested
  belongs_to :user
  belongs_to :film
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :hashtag, through: :taggings, dependent: :destroy

  validates_presence_of :title

  delegate :name, to: :film, prefix: true

  mount_uploader :banner, ThumbnailUploader
  mount_uploader :thumbnail, ThumbnailUploader

  scope :find_by_film_ids, ->(films) {where film_id: films}
  scope :find_by_comment, ->(comment) {where id: comment.review_id}
end
