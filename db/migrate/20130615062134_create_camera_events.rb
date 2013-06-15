class CreateCameraEvents < ActiveRecord::Migration
  def change
    create_table :camera_events do |t|
    	t.belongs_to :camera

      t.timestamps
    end
    add_attachment :camera_events, :video
  end
end
