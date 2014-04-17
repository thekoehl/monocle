class AddUnacknowledgedAlarmsToSensors < ActiveRecord::Migration
  def change
    change_table :sensors do |t|
      t.boolean :needs_attention, default: false
    end
  end
end
