class RemoveCategoriesFromTours < ActiveRecord::Migration[5.2]
  def change
    remove_column :tours, :category_id
  end
end
