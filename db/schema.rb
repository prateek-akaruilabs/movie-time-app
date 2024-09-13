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

ActiveRecord::Schema[7.1].define(version: 2024_09_06_060603) do
  create_table "bookings", force: :cascade do |t|
    t.string "booking_id"
    t.decimal "total_seat_charges"
    t.decimal "total_convenience_charges"
    t.decimal "food_and_beverage_charges"
    t.decimal "total_amount"
    t.string "ticket_type"
    t.json "food_and_beverage_details"
    t.json "seat_details"
    t.date "movie_date"
    t.json "seats_booked", default: []
    t.string "booking_status"
    t.integer "user_id", null: false
    t.integer "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_bookings_on_show_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cinemas", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.string "language"
    t.string "industry"
    t.text "description"
    t.integer "length"
    t.float "rating"
    t.string "age_category"
    t.datetime "launch_date"
    t.text "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "payment_id"
    t.string "payment_type"
    t.string "payment_provider"
    t.decimal "payment_amount"
    t.string "payment_status"
    t.text "description"
    t.text "failure_reason"
    t.datetime "failed_at"
    t.datetime "paid_at"
    t.integer "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
  end

  create_table "screens", force: :cascade do |t|
    t.string "name"
    t.integer "cinema_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id"], name: "index_screens_on_cinema_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "number"
    t.string "row"
    t.string "category"
    t.decimal "price"
    t.integer "screen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screen_id"], name: "index_seats_on_screen_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "show_time"
    t.integer "movie_id", null: false
    t.integer "screen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["screen_id"], name: "index_shows_on_screen_id"
  end

  create_table "snacks", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 5, scale: 2
    t.string "food_type"
    t.string "category"
    t.boolean "in_stock"
    t.float "discount_perc"
    t.text "image_url"
    t.integer "cinema_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id"], name: "index_snacks_on_cinema_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "bookings", "shows"
  add_foreign_key "bookings", "users"
  add_foreign_key "payments", "bookings"
  add_foreign_key "screens", "cinemas"
  add_foreign_key "seats", "screens"
  add_foreign_key "shows", "movies"
  add_foreign_key "shows", "screens"
  add_foreign_key "snacks", "cinemas"
end
