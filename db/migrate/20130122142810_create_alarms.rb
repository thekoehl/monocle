class CreateAlarms < ActiveRecord::Migration
	def change
		create_table :alarms do |t|
			t.belongs_to :sensor

			t.boolean    :active
			t.integer    :trigger_value
			t.string     :trigger_type
			t.datetime   :last_triggered

			t.timestamps
		end
	end
end
