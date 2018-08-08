class AddInfoToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :country, :string
    add_column :films, :release_date, :date
  end
end
