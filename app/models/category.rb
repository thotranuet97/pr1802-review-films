class Category < ApplicationRecord
  has_many :film_categories, dependent: :destroy
  has_many :films, through: :film_categories, dependent: :destroy

  validates_presence_of :name

  scope :order_asc, -> {order name: :asc}
end
