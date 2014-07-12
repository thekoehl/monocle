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

ActiveRecord::Schema.define(version: 20140712174636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cameras", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "latest_image_uploaded_at"
    t.string   "latest_image_file_name"
    t.string   "latest_image_content_type"
    t.integer  "latest_image_file_size"
    t.datetime "latest_image_updated_at"
  end

  create_table "data_points", force: true do |t|
    t.decimal  "value"
    t.datetime "logged_at"
    t.integer  "sensor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_points", ["sensor_id"], name: "index_data_points_on_sensor_id", using: :btree

  create_table "events", force: true do |t|
    t.integer  "sensor_id"
    t.boolean  "acknowledged"
    t.string   "event_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["sensor_id"], name: "index_events_on_sensor_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "sensors", force: true do |t|
    t.string   "name"
    t.string   "units"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "last_value"
    t.decimal  "high_level"
    t.decimal  "low_level"
    t.integer  "signal_fault_delay"
    t.datetime "last_notification_sent_at"
    t.boolean  "needs_attention",           default: false
  end

  add_index "sensors", ["group_id"], name: "index_sensors_on_group_id", using: :btree

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

  add_index "users", ["api_key"], name: "index_users_on_api_key", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
