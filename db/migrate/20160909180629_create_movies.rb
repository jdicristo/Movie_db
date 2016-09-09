class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :movie_title
      t.integer :year

      t.timestamps
    end
  end
end
