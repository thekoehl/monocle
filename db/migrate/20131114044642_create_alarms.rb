class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|

    	t.integer 	:sensor_id
    	t.string 		:alarm_type
    	t.integer 	:trigger_value
    	t.datetime  :last_notification_sent_at
    	t.datetime 	:last_triggered_at

      t.timestamps
    end

  end
end
