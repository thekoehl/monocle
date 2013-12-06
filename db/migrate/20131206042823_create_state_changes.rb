class CreateStateChanges < ActiveRecord::Migration
  def change
    create_table :state_changes do |t|
      t.integer :sensor_id

      t.string :old_state
      t.string :new_state

      t.timestamps
    end
  end
end
