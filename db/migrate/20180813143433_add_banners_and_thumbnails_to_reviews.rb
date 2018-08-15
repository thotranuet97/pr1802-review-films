class AddBannersAndThumbnailsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :banner, :string
    add_column :reviews, :thumbnail, :string
  end
end
