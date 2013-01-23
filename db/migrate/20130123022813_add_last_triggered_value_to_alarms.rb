class AddLastTriggeredValueToAlarms < ActiveRecord::Migration
  def change
    change_table :alarms do |t|
    	t.integer :last_triggered_value      
    end
  end
end
