class ChangePhotosToString < ActiveRecord::Migration[5.2]
  def change
    change_column :tours, :photos, :string
  end
end
