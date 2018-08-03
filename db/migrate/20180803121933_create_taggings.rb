class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.references :review, foreign_key: true
      t.references :hashtag, foreign_key: true

      t.timestamps
    end
  end
end
