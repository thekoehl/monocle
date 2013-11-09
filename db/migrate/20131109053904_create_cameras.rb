class CreateCameras < ActiveRecord::Migration
  def change
    create_table :cameras do |t|
    	t.integer :user_id
    	t.string :name
      t.timestamps
    end
    add_attachment :cameras, :latest_snapshot
  end
end
