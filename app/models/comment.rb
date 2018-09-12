class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :content
  validates_length_of :content,
    minimum: Settings.comment.content.length.minimum,
    allow_blank: true
end
