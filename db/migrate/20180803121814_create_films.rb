class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :name
      t.string :introduction
      t.string :poster
      t.string :thumbnail
      t.string :trailer
      t.string :video_thumbnail
      t.string :actors
      t.string :directors
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
