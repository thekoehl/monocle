class AddMoreFieldsToSensors < ActiveRecord::Migration
  def change
    change_table :sensors do |t|
      t.integer :high_level
      t.integer :low_level
      t.integer :signal_fault_delay
      t.datetime :last_notification_sent_at
    end
  end
end
