class AddLastValueToSensor < ActiveRecord::Migration
  def change
    change_table :sensors do |t|
      t.decimal :last_value
    end
  end
end
