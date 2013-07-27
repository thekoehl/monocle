class AddMaximumValueRecalculatedAtToSensors < ActiveRecord::Migration
  def change
  	add_column :sensors, :maximum_value_recalculated_at, :datetime
  end
end
