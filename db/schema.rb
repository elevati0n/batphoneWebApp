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

ActiveRecord::Schema.define(version: 20151125214943) do

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["micropost_id"], name: "index_comments_on_micropost_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "devices", force: :cascade do |t|
    t.string   "name"
    t.string   "IP_address"
    t.string   "MAC"
    t.string   "AP_SSID"
    t.string   "Gateway_mode"
    t.text     "description"
    t.text     "location"
    t.text     "notes"
    t.integer  "network_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "devices", ["network_id"], name: "index_devices_on_network_id"

  create_table "groups", force: :cascade do |t|
    t.string   "member"
    t.string   "recording"
    t.string   "comment"
    t.string   "batphone"
    t.string   "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.string   "subject"
    t.integer  "device_id"
    t.integer  "network_id"
    t.boolean  "private"
  end

  add_index "microposts", ["device_id"], name: "index_microposts_on_device_id"
  add_index "microposts", ["network_id"], name: "index_microposts_on_network_id"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "networks", force: :cascade do |t|
    t.string   "name"
    t.text     "publickey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recordings", force: :cascade do |t|
    t.string   "originator"
    t.string   "time"
    t.string   "date"
    t.string   "URI"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "profile"
    t.string   "friends"
    t.string   "groups"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
