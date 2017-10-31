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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "photo_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_comments_on_photo_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "private_key"
    t.bigint "user_id"
    t.date "gallery_on"
    t.integer "default_photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_galleries_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "gallery_id"
    t.string "artist"
    t.string "caption"
    t.integer "sequence"
    t.integer "views", default: 0, null: false
    t.string "img"
    t.datetime "photo_at"
    t.string "shutter_speed"
    t.string "aperture"
    t.string "focal_length"
    t.string "iso"
    t.string "exposure_mode"
    t.string "flash"
    t.string "exposure_compensation"
    t.string "camera_model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gallery_id"], name: "index_photos_on_gallery_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "authority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
