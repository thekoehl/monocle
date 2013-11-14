class CreateCameraEvents < ActiveRecord::Migration
  def change
    create_table :camera_events do |t|
    	t.integer :user_id
    	t.string :location
      t.timestamps
    end
    add_attachment :camera_events, :event_recording
  end
end
