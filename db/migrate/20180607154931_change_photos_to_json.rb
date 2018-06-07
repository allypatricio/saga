class ChangePhotosToJson < ActiveRecord::Migration[5.2]
  def change
    remove_column :tours, :photos
    add_column :tours, :photos, :json
  end
end
