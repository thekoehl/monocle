class AddUserIdToAlarms < ActiveRecord::Migration
  def change
  	change_table :alarms do |t|
  		t.integer :user_id
  	end
  end
end
