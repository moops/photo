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

ActiveRecord::Schema.define(version: 20120921193440) do

  create_table "comments", force: true do |t|
    t.integer  "photo_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "private_key"
    t.integer  "user_id"
    t.date     "gallery_on"
    t.string   "default_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "gallery_id"
    t.string   "artist"
    t.string   "caption"
    t.integer  "sequence"
    t.integer  "views"
    t.string   "img"
    t.datetime "photo_at"
    t.string   "shutter_speed"
    t.string   "aperture"
    t.string   "focal_length"
    t.string   "iso"
    t.string   "exposure_mode"
    t.string   "flash"
    t.string   "exposure_compensation"
    t.string   "camera_model"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "authority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
