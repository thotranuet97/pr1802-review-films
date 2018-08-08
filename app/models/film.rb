class Film < ApplicationRecord
  belongs_to :user
  has_one :review
  has_many :ratings
  has_many :raters, class_name: User.name, through: :ratings
  has_many :film_categories
  has_many :categories, through: :film_categories

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true

  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :poster, ThumbnailUploader
  mount_uploader :video_thumbnail, ThumbnailUploader
end
