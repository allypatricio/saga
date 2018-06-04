class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :tour, foreign_key: true
      t.string :address
      t.string :photo
      t.string :story
      t.string :question
      t.string :hint
      t.string :answer
      t.integer :position

      t.timestamps
    end
  end
end
