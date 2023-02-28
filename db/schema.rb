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

ActiveRecord::Schema.define(version: 2023_02_28_210332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_tea_subscriptions", force: :cascade do |t|
    t.string "title"
    t.string "price"
    t.string "status"
    t.string "frequency"
    t.bigint "customer_id"
    t.bigint "tea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_tea_subscriptions_on_customer_id"
    t.index ["tea_id"], name: "index_customer_tea_subscriptions_on_tea_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "temperature"
    t.string "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer_tea_subscriptions", "customers"
  add_foreign_key "customer_tea_subscriptions", "teas"
end