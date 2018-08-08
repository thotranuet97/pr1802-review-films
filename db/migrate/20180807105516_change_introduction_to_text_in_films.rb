class ChangeIntroductionToTextInFilms < ActiveRecord::Migration[5.2]
  def change
    change_column :films, :introduction, :text
  end
end
