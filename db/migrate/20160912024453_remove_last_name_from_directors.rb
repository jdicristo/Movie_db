class RemoveLastNameFromDirectors < ActiveRecord::Migration[5.0]
  def change
  	remove_column :directors, :last_name
  	rename_column :directors, :first_name, :name
  end
end
