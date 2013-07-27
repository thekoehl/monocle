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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130727024746) do

  create_table "alarms", :force => true do |t|
    t.integer  "sensor_id"
    t.boolean  "active"
    t.integer  "trigger_value"
    t.string   "trigger_type"
    t.datetime "last_triggered"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "last_triggered_value"
  end

  create_table "camera_events", :force => true do |t|
    t.integer  "camera_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

  create_table "cameras", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "latest_snapshot_file_name"
    t.string   "latest_snapshot_content_type"
    t.integer  "latest_snapshot_file_size"
    t.datetime "latest_snapshot_updated_at"
  end

  create_table "data_points", :force => true do |t|
    t.integer  "value"
    t.string   "reporter"
    t.integer  "sensor_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "units"
    t.string   "created_at_monthly"
    t.string   "created_at_hourly"
    t.string   "created_at_daily"
  end

  create_table "pages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reporting_dashboards", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "reporting_dashboards_sensors", :force => true do |t|
    t.integer "reporting_dashboard_id"
    t.integer "sensor_id"
  end

  create_table "sensors", :force => true do |t|
    t.string   "name"
    t.string   "reporter"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "maximum_value", :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "email",                     :default => "", :null => false
    t.string   "encrypted_password",        :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "api_key"
    t.datetime "last_notification_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
