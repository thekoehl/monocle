class AddMoreFieldsToSensors < ActiveRecord::Migration
  def change
    change_table :sensors do |t|
      t.integer :high_level
      t.integer :low_level
      t.integer :signal_fault_delay
    end
  end
end
