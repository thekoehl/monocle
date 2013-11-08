class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.integer :sensor_id
      t.integer :value

      t.datetime :hourly_segmentation
      t.datetime :daily_segmentation
      t.datetime :monthly_segmentation

      t.timestamps
    end
  end
end
