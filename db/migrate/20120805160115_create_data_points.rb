class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.integer :value
      t.string :reporter

      t.integer :sensor_id      
      t.timestamps
    end
  end
end
