class RenameNumericSensorToSensorForDps < ActiveRecord::Migration
  def up
    rename_column :data_points, :numeric_sensor_id, :sensor_id
  end
  def down
    rename_column :data_points, :sensor_id, :numeric_sensor_id
  end
end
