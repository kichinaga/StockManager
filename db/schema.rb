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

ActiveRecord::Schema.define(version: 20171026123311) do

  create_table "companies", force: :cascade do |t|
    t.integer "stock_code"
    t.string "name"
    t.integer "market_id"
    t.integer "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_companies_on_industry_id"
    t.index ["market_id"], name: "index_companies_on_market_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "markets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_details", force: :cascade do |t|
    t.integer "company_id"
    t.string "price"
    t.string "change"
    t.string "prev_close_price"
    t.string "open_price"
    t.string "high_price"
    t.string "low_price"
    t.string "volume"
    t.string "total_trade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_stock_details_on_company_id"
  end

  create_table "stock_lists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_stock_lists_on_company_id"
    t.index ["user_id"], name: "index_stock_lists_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "num"
    t.integer "first_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stock_list_id"
    t.index ["stock_list_id"], name: "index_stocks_on_stock_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
