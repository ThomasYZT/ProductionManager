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

ActiveRecord::Schema.define(version: 20160406023430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "title"
  end

  create_table "companies", force: :cascade do |t|
    t.string  "title"
    t.integer "city_id"
  end

  create_table "contract_changes", force: :cascade do |t|
    t.integer  "contract_id"
    t.string   "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "breed"
    t.decimal  "cultivated_area",   precision: 10, scale: 2
    t.integer  "transplant_number"
    t.integer  "purchase"
    t.integer  "party_a_id"
    t.integer  "party_b_id"
    t.integer  "user_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "contract_no"
    t.integer  "initial_id"
  end

  create_table "party_as", force: :cascade do |t|
    t.string   "city"
    t.string   "company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "party_bs", force: :cascade do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "phone"
    t.string   "card_number"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "bank"
  end

  create_table "stations", force: :cascade do |t|
    t.string "title"
    t.string "code"
  end

  create_table "users", force: :cascade do |t|
    t.string   "userid"
    t.string   "username"
    t.string   "hashed_password"
    t.string   "role"
    t.integer  "station_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "salt"
    t.string   "phone"
    t.string   "token"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "version_code"
    t.integer  "version_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
