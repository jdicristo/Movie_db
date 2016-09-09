class CreateMovieTags < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_tags do |t|
      t.integer :movie_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
