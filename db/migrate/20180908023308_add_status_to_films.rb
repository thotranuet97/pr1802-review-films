class AddStatusToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :status, :integer, default: 1
  end
end
