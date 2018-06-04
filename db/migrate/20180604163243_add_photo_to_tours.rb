class AddPhotoToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :photo, :string
  end
end
