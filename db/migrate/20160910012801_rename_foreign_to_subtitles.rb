class RenameForeignToSubtitles < ActiveRecord::Migration[5.0]
  def change
    rename_column :movies, :foreign, :subtitles
  end
end
