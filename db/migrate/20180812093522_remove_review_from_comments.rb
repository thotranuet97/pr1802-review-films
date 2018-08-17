class RemoveReviewFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_reference :comments, :review, foreign_key: true
  end
end
