class AddPhotosToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :photos, :json
  end
end
