class AddGuideToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :guide, :boolean, :default => 0
  end
end
