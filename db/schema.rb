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

ActiveRecord::Schema.define(version: 20141205053833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: true do |t|
    t.string   "writer"
    t.string   "title"
    t.text     "content"
    t.integer  "count"
    t.integer  "level"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "point"
    t.integer  "level"
    t.integer  "code"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", id: false, force: true do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "message_groups", force: true do |t|
    t.string  "body"
    t.integer "message_type"
  end

  create_table "messages", force: true do |t|
    t.integer "message_group_id"
    t.integer "result"
    t.string  "cmid"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "degree"
    t.string   "group_name"
    t.string   "major"
    t.string   "student_number"
    t.string   "phone_number"
    t.string   "email"
    t.string   "profile_img_name"
    t.string   "grade"
    t.string   "address"
    t.string   "company"
    t.string   "register"
    t.string   "position"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
