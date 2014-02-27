class RemoteStatefulSensors < ActiveRecord::Migration
  def up
    drop_table :state_changes
  end
  def down
    create_table :state_changes do |t|
      t.integer :stateful_sensor_id

      t.string :old_state
      t.string :new_state

      t.timestamps
    end
  end
end
