class DeletePhotosFromTours < ActiveRecord::Migration[5.2]
  def change
    remove_column :tours, :photos
  end
end
