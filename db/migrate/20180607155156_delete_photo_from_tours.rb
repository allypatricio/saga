class DeletePhotoFromTours < ActiveRecord::Migration[5.2]
  def change
    remove_column :tours, :photo
  end
end
