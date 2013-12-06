class AddTypeToSensors < ActiveRecord::Migration
  def change
    change_table :sensors do |t|
      t.string :type
    end
  end
end
