class ChangeTourDurationToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :tours, :duration, :float
  end
end
