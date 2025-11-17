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

ActiveRecord::Schema[8.1].define(version: 2025_11_16_214924) do
  create_table "audios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "used_product_id", null: false
    t.index ["used_product_id"], name: "index_audios_on_used_product_id"
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "product_id", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["product_id"], name: "index_images_on_product_id"
  end

  create_table "new_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "product_id", null: false
    t.integer "stock"
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_new_products_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "author"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "date_removed"
    t.string "description"
    t.datetime "last_modification"
    t.string "name"
    t.decimal "price"
    t.string "type"
    t.datetime "updated_at", null: false
    t.datetime "upload_date"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "type"
    t.datetime "updated_at", null: false
  end

  create_table "sale_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "price"
    t.integer "product_id", null: false
    t.integer "quantity"
    t.integer "sale_id", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sale_products_on_product_id"
    t.index ["sale_id"], name: "index_sale_products_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.boolean "completed", default: true
    t.datetime "created_at", null: false
    t.datetime "date"
    t.decimal "total"
    t.datetime "updated_at", null: false
  end

  create_table "used_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "product_id", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_used_products_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "surname"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "audios", "used_products"
  add_foreign_key "images", "products"
  add_foreign_key "new_products", "products"
  add_foreign_key "sale_products", "products"
  add_foreign_key "sale_products", "sales"
  add_foreign_key "used_products", "products"
end
