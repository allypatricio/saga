class AddCategoryToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :category, :string
  end
end
