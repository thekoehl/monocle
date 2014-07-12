class CreateCameras < ActiveRecord::Migration
  def change
    create_table :cameras do |t|
      t.integer  :user_id
      t.string   :name
      t.datetime :latest_image_uploaded_at
    end
    add_attachment :cameras, :latest_image
  end
end
