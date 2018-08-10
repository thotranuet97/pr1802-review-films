class AddAvgToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :average_ratings, :string
  end
end
