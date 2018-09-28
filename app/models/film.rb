class Film < ApplicationRecord
  include Filter

  belongs_to :user
  has_one :review, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user, dependent: :destroy
  has_many :film_categories, dependent: :destroy
  has_many :categories, through: :film_categories, dependent: :destroy

  enum status: {publish: 1, pending: 0}

  validates :name, presence: true

  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :poster, ThumbnailUploader
  mount_uploader :video_thumbnail, ThumbnailUploader

  scope :order_created_desc, -> {order created_at: :desc}

  scope :order_released_desc, -> {order release_date: :desc}

  scope :related_films, -> (film) do
    joins(:film_categories).where("category_id IN (?)", film.category_ids)
      .where.not(id: film.id).distinct.limit Settings.films.related_limit
  end

  scope :this_month, -> do
    where("month(release_date) like ?", Time.now.month)
  end

  scope :recently_released, -> do
    where("release_date < ?", Time.now).limit Settings.films.spotlight_limit
  end
  scope :top_rated, -> do
    order(average_ratings: :desc).limit Settings.films.spotlight_limit
  end

  scope :coming_soon, -> do
    where("release_date > ?", Time.now).order(release_date: :asc)
      .limit Settings.films.spotlight_limit
  end

  scope :search_with_option, ->(search_option, search_content) do
    where "#{search_option} like ?","%#{search_content}%"
  end

  scope :search_all, -> (search_content) do
    where("name like ?","%#{search_content}%")
      .or(where "actors like ?","%#{search_content}%")
      .or where "directors like ?","%#{search_content}%"
  end

  scope :search_in_cat, ->(search_params) do
    where "name like ?", "%#{search_params}%"
  end

  scope :sort_films, ->(sort_params){order("#{sort_params}")}

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

  def self.to_csv options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |film|
        csv << film.attributes.values_at(*column_names)
      end
    end
  end
end
