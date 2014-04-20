class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :sensor_id
      t.boolean :acknowledged
      t.string :event_type
      t.timestamps
    end
    add_index :events, :sensor_id
  end
end
