class CreateCameras < ActiveRecord::Migration
  def change
    create_table :cameras do |t|
      t.belongs_to :user
      t.string :title
      
      t.timestamps
    end
    add_attachment :cameras, :latest_snapshot
  end
end
