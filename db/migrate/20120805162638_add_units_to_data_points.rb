class AddUnitsToDataPoints < ActiveRecord::Migration
	def change
        change_table :data_points do |t|
            t.string :units
        end
	end
end
