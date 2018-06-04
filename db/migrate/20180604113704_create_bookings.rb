class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true
      t.integer :status
      t.datetime :start_time
      t.datetime :end_time
      t.integer :hints_used

      t.timestamps
    end
  end
end
