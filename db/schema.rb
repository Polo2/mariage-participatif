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

ActiveRecord::Schema.define(version: 2019_11_10_140616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomodations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.string "location"
    t.string "contact_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wedding_id"
    t.string "contact_email"
    t.string "contact_website"
    t.string "contact_phone"
    t.integer "distance"
    t.string "category"
    t.boolean "complete"
    t.index ["wedding_id"], name: "index_accomodations_on_wedding_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "name"
    t.bigint "wedding_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wedding_id"], name: "index_discussions_on_wedding_id"
  end

  create_table "guests", id: :serial, force: :cascade do |t|
    t.integer "registry_id", null: false
    t.string "name", null: false
    t.boolean "presence", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "child"
    t.integer "service_id"
    t.index ["registry_id"], name: "index_guests_on_registry_id"
    t.index ["service_id"], name: "index_guests_on_service_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "read"
    t.string "resource_type"
    t.bigint "resource_id"
    t.index ["resource_type", "resource_id"], name: "index_messages_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registries", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "wedding_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.integer "total"
    t.string "group_name"
    t.string "address"
    t.integer "zipcode"
    t.string "city"
    t.integer "accomodation_id"
    t.integer "score_registry"
    t.index ["accomodation_id"], name: "index_registries_on_accomodation_id"
    t.index ["user_id"], name: "index_registries_on_user_id"
    t.index ["wedding_id"], name: "index_registries_on_wedding_id"
  end

  create_table "services", id: :serial, force: :cascade do |t|
    t.integer "capacity"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.datetime "start_at"
    t.datetime "stop_at"
    t.string "description"
    t.index ["task_id"], name: "index_services_on_task_id"
  end

  create_table "tasks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wedding_id"
    t.boolean "statut"
    t.index ["wedding_id"], name: "index_tasks_on_wedding_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.datetime "token_expiry"
    t.string "location"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vegetables", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "photo"
    t.integer "registry_id"
    t.string "slogan"
    t.integer "capacity"
    t.index ["registry_id"], name: "index_vegetables_on_registry_id"
  end

  create_table "weddings", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "date"
    t.string "location"
    t.string "photo"
    t.integer "capacity"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "token"
    t.string "spouse_photo"
    t.string "spouse_first_name"
    t.string "spouse_last_name"
    t.date "deadline"
    t.index ["user_id"], name: "index_weddings_on_user_id"
  end

  add_foreign_key "messages", "users"
  add_foreign_key "registries", "users"
  add_foreign_key "registries", "weddings"
  add_foreign_key "services", "tasks"
  add_foreign_key "tasks", "weddings"
  add_foreign_key "weddings", "users"
end
