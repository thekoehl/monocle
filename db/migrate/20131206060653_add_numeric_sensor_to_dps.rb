class AddNumericSensorToDps < ActiveRecord::Migration
  def change
    rename_column :data_points, :sensor_id, :numeric_sensor_id
  end
end
