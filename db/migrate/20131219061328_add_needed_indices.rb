class AddNeededIndices < ActiveRecord::Migration
  def change
    add_index :sensors, :user_id
    add_index :cameras, :user_id
    add_index :camera_events, :user_id
    add_index :alarms, :user_id
    add_index :alarms, :sensor_id
  end
end
