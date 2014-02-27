class AddIndexToSensorIdOnDatapoints < ActiveRecord::Migration
  def change
    add_index :data_points, :sensor_id
  end
end
