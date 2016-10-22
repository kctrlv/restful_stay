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

ActiveRecord::Schema.define(version: 20161022223825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
    t.string   "image_url",  default: "https://i.ytimg.com/vi/TDXXQz8amFU/maxresdefault.jpg"
  end

  create_table "days", force: :cascade do |t|
    t.date "date"
  end

  create_table "listing_days", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "day_id"
    t.string   "status",     default: "available"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["day_id"], name: "index_listing_days_on_day_id", using: :btree
    t.index ["listing_id"], name: "index_listing_days_on_listing_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image_url"
    t.decimal  "price_per_night"
    t.integer  "city_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "host_id"
    t.index ["city_id"], name: "index_listings_on_city_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "password_digest"
    t.string   "phone_number"
    t.string   "description",       default: "No Description"
    t.string   "picture_url",       default: "https://www.mautic.org/media/images/default_avatar.png"
    t.string   "status",            default: "inactive"
    t.datetime "created_at",                                                                           null: false
    t.datetime "updated_at",                                                                           null: false
    t.string   "verification_code"
  end

  add_foreign_key "listing_days", "days"
  add_foreign_key "listing_days", "listings"
  add_foreign_key "listings", "cities"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
