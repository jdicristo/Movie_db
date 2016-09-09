class AddBestPictureToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :best_picture_winner, :boolean
    add_column :movies, :best_picture_nominee, :boolean
  end
end
