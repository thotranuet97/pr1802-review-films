class Film < ApplicationRecord
  belongs_to :user
  has_one :review, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user, dependent: :destroy
  has_many :film_categories, dependent: :destroy
  has_many :categories, through: :film_categories, dependent: :destroy

  validates :name, presence: true

  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :poster, ThumbnailUploader
  mount_uploader :video_thumbnail, ThumbnailUploader

  scope :order_films, -> {order created_at: :desc}
  scope :related_films, -> (film) do
    joins(:film_categories).where("category_id IN (?)", film.category_ids)
      .where.not(id: film.id).distinct.limit 3
  end
  
  scope :sort_films, ->(sort_params){ order("#{sort_params} desc") }

  scope :release_years_list, -> do
    select("year(release_date) as release_date")
      .where("release_date is not null")
      .distinct("release_date")
      .order "release_date asc"
  end
  scope :filter_by_year, ->(year_params) do
    where "year(release_date) like ?", "#{year_params}"
  end

  scope :directors_list, -> do
    select("directors").where("directors is not null")
      .distinct("directors")
      .order "directors asc"
  end
  scope :filter_by_director, ->(director_params) do
    where "directors like ?", "#{director_params}"
  end

  scope :filter_by_interval, ->(start_date, end_date) do
    where("release_date between ? and ?", "#{start_date}", "#{end_date}")
    .distinct "release_date"
  end
end
