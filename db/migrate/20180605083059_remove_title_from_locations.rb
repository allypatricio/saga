class RemoveTitleFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :title
  end
end
