# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140227043807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alarms", force: true do |t|
    t.integer  "sensor_id"
    t.string   "alarm_type"
    t.integer  "trigger_value"
    t.datetime "last_notification_sent_at"
    t.datetime "last_triggered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "alarms", ["sensor_id"], name: "index_alarms_on_sensor_id", using: :btree
  add_index "alarms", ["user_id"], name: "index_alarms_on_user_id", using: :btree

  create_table "camera_events", force: true do |t|
    t.integer  "user_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_recording_file_name"
    t.string   "event_recording_content_type"
    t.integer  "event_recording_file_size"
    t.datetime "event_recording_updated_at"
  end

  add_index "camera_events", ["user_id"], name: "index_camera_events_on_user_id", using: :btree

  create_table "cameras", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "latest_snapshot_file_name"
    t.string   "latest_snapshot_content_type"
    t.integer  "latest_snapshot_file_size"
    t.datetime "latest_snapshot_updated_at"
  end

  add_index "cameras", ["user_id"], name: "index_cameras_on_user_id", using: :btree

  create_table "data_points", force: true do |t|
    t.integer  "numeric_sensor_id"
    t.integer  "value"
    t.string   "hourly_segmentation"
    t.string   "daily_segmentation"
    t.string   "monthly_segmentation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sensors", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "sensors", ["user_id"], name: "index_sensors_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_key"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
