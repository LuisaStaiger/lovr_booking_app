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

ActiveRecord::Schema[7.1].define(version: 2024_05_22_133502) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "available_slots", force: :cascade do |t|
    t.datetime "date"
    t.string "time_frame"
    t.integer "duration"
    t.integer "festival_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "love_pod_id"
    t.datetime "start_time"
    t.integer "price_cents", default: 0, null: false
    t.string "sku"
    t.index ["festival_id"], name: "index_available_slots_on_festival_id"
    t.index ["love_pod_id"], name: "index_available_slots_on_love_pod_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "booking_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.integer "status", default: 0
    t.datetime "start_time"
    t.integer "available_slot_id"
    t.string "slots_sku"
    t.string "checkout_session_id"
    t.integer "amount_cents", default: 0, null: false
    t.index ["available_slot_id"], name: "index_bookings_on_available_slot_id"
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
    t.integer "duration_25", default: 25
    t.integer "duration_55", default: 55
    t.time "availabilty_start_time", default: "2000-01-01 09:00:00"
    t.time "availabilty_end_time", default: "2000-01-01 23:00:00"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "available_slots", "festivals"
  add_foreign_key "available_slots", "love_pods"
  add_foreign_key "bookings", "available_slots"
  add_foreign_key "bookings", "users"
  add_foreign_key "festival_love_pods", "festivals"
  add_foreign_key "festival_love_pods", "love_pods"
end
