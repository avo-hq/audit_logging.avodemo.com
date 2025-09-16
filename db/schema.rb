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

ActiveRecord::Schema[7.2].define(version: 2025_09_16_094614) do
  create_table "avo_audit_logging_activities", force: :cascade do |t|
    t.string "activity_class"
    t.string "action"
    t.bigint "author_id"
    t.string "author_type"
    t.text "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "avo_audit_logging_activity_pivots", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.string "activity_pivot_type"
    t.integer "activity_pivot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_avo_audit_logging_activity_pivots_on_activity_id"
    t.index ["activity_pivot_type", "activity_pivot_id"], name: "index_avo_audit_logging_activity_pivots_on_activity_pivot"
    t.index ["record_type", "record_id"], name: "index_avo_audit_logging_activity_pivots_on_record"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.integer "total_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "description", null: false
    t.integer "price", null: false
    t.integer "quantity", null: false
    t.string "manufacturer", null: false
    t.integer "category", null: false
    t.boolean "is_featured", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inventory_id"
    t.index ["inventory_id"], name: "index_products_on_inventory_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.json "roles"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "whodunnit"
    t.datetime "created_at"
    t.bigint "item_id", null: false
    t.string "item_type", null: false
    t.string "event", null: false
    t.text "object", limit: 1073741823
    t.text "object_changes", limit: 1073741823
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "products", "inventories"
  add_foreign_key "products", "users"
end
