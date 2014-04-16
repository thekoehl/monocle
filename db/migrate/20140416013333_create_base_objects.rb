class CreateBaseObjects < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
    create_table :sensors do |t|
      t.string :name
      t.string :units
      t.integer :group_id
      t.timestamps
    end
    create_table :data_points do |t|
      t.decimal :value
      t.datetime :logged_at

      t.integer :sensor_id
      t.timestamps
    end
    add_index :users, :api_key
    add_index :groups, :user_id
    add_index :sensors, :group_id
    add_index :data_points, :sensor_id
  end
end
