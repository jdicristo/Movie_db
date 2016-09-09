class AddForeignAndSeenToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :seen, :boolean
    add_column :movies, :foreign, :boolean
  end
end
