# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_26_102635) do
  create_table "available_slots", force: :cascade do |t|
    t.datetime "date"
    t.string "time_frame"
    t.integer "duration"
    t.integer "festival_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["festival_id"], name: "index_available_slots_on_festival_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "booking_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.integer "status", default: 0
    t.integer "festival_id"
    t.integer "love_pod_id"
    t.datetime "start_time"
    t.index ["festival_id"], name: "index_bookings_on_festival_id"
    t.index ["love_pod_id"], name: "index_bookings_on_love_pod_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "festival_love_pods", force: :cascade do |t|
    t.integer "festival_id", null: false
    t.integer "love_pod_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["festival_id"], name: "index_festival_love_pods_on_festival_id"
    t.index ["love_pod_id"], name: "index_festival_love_pods_on_love_pod_id"
  end

  create_table "festivals", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "love_pods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "capacity"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "available_slots", "festivals"
  add_foreign_key "bookings", "festivals"
  add_foreign_key "bookings", "love_pods"
  add_foreign_key "bookings", "users"
  add_foreign_key "festival_love_pods", "festivals"
  add_foreign_key "festival_love_pods", "love_pods"
end
