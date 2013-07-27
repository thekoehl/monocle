class AddMinimumValueToSensors < ActiveRecord::Migration
  def change
  	add_column :sensors, :minimum_value, :integer, default: 0
  	add_column :sensors, :minimum_value_recalculated_at, :datetime
  end
end
