class AddRatingToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :rating_id, :integer
  end
end
