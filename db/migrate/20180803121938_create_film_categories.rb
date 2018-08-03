class CreateFilmCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :film_categories do |t|
      t.references :film, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
