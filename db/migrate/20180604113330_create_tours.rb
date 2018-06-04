class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title
      t.integer :price
      t.integer :duration
      t.integer :status

      t.timestamps
    end
  end
end
