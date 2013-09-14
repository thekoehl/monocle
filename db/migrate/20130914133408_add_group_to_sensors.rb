class AddGroupToSensors < ActiveRecord::Migration
  def change
  	add_column :sensors, :group_name, :string
  end
end
