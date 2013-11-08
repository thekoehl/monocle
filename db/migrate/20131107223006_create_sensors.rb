class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.integer :user_id

      t.string :name
      t.string :units

      t.timestamps
    end
  end
end
