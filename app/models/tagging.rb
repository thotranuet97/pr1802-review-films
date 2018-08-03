class Tagging < ApplicationRecord
  belongs_to :review
  belongs_to :hashtag
end
