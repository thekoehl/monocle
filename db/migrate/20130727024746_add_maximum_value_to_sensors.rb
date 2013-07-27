class AddMaximumValueToSensors < ActiveRecord::Migration
  def change
  	add_column :sensors, :maximum_value, :integer, default: 0
  end
end
