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

ActiveRecord::Schema[7.1].define(version: 2024_04_09_032020) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "isan", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["isan"], name: "index_authors_on_isan", unique: true
  end

  create_table "publishers", force: :cascade do |t|
    t.string "ispn", null: false
    t.string "name", null: false
    t.string "country_of_origin", null: false
    t.date "founded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ispn"], name: "index_publishers_on_ispn", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_categories_on_code", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn", null: false
    t.string "title", null: false
    t.integer "number_of_pages", null: false
    t.integer "edition_number", null: false
    t.integer "publication_year", null: false
    t.string "author_isan", null: false
    t.string "publisher_ispn", null: false
    t.string "category_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
    t.index ["author_isan"], name: "index_books_on_author_isan"
    t.index ["publisher_ispn"], name: "index_books_on_publisher_ispn"
    t.index ["category_code"], name: "index_books_on_category_code"
  end

  add_foreign_key "books", "authors", column: "author_isan", primary_key: "isan"
  add_foreign_key "books", "publishers", column: "publisher_ispn", primary_key: "ispn"
  add_foreign_key "books", "categories", column: "category_code", primary_key: "code"
end
