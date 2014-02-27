class RemoveTypeFromSensors < ActiveRecord::Migration
  def up
    remove_column :sensors, :type    
  end
  def down
    change_table :sensors do |t|
      t.string :type
    end
  end
end
