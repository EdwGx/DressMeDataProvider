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

ActiveRecord::Schema.define(version: 20160313105815) do

  create_table "article_to_situations", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "situation_id"
    t.integer  "score",        default: 100
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "article_to_situations", ["article_id"], name: "index_article_to_situations_on_article_id"
  add_index "article_to_situations", ["situation_id"], name: "index_article_to_situations_on_situation_id"

  create_table "articles", force: :cascade do |t|
    t.integer  "position"
    t.string   "name"
    t.integer  "score",      default: 100
    t.integer  "temp_max"
    t.integer  "temp_min"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "articles_combinations", force: :cascade do |t|
    t.integer "article_id"
    t.integer "combination_id"
  end

  add_index "articles_combinations", ["article_id"], name: "index_articles_combinations_on_article_id"
  add_index "articles_combinations", ["combination_id"], name: "index_articles_combinations_on_combination_id"

  create_table "clothes", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "color_id"
    t.string   "raw_description"
    t.integer  "score",           default: 100
    t.integer  "position"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "clothes", ["article_id"], name: "index_clothes_on_article_id"
  add_index "clothes", ["color_id"], name: "index_clothes_on_color_id"

  create_table "clothes_suggestions", force: :cascade do |t|
    t.integer "clothe_id"
    t.integer "suggestion_id"
  end

  add_index "clothes_suggestions", ["clothe_id"], name: "index_clothes_suggestions_on_clothe_id"
  add_index "clothes_suggestions", ["suggestion_id"], name: "index_clothes_suggestions_on_suggestion_id"

  create_table "clothes_tags", force: :cascade do |t|
    t.integer "clothe_id"
    t.integer "tag_id"
  end

  add_index "clothes_tags", ["clothe_id"], name: "index_clothes_tags_on_clothe_id"
  add_index "clothes_tags", ["tag_id"], name: "index_clothes_tags_on_tag_id"

  create_table "color_to_situations", force: :cascade do |t|
    t.integer  "color_id"
    t.integer  "situation_id"
    t.integer  "score",        default: 100
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "color_to_situations", ["color_id"], name: "index_color_to_situations_on_color_id"
  add_index "color_to_situations", ["situation_id"], name: "index_color_to_situations_on_situation_id"

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.integer  "score",      default: 100
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "combination_to_situations", force: :cascade do |t|
    t.integer  "combination_id"
    t.integer  "situation_id"
    t.integer  "score",          default: 100
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "combination_to_situations", ["combination_id"], name: "index_combination_to_situations_on_combination_id"
  add_index "combination_to_situations", ["situation_id"], name: "index_combination_to_situations_on_situation_id"

  create_table "combinations", force: :cascade do |t|
    t.integer  "score",      default: 100
    t.string   "khash"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "situations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer  "response"
    t.integer  "situation_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "suggestions", ["situation_id"], name: "index_suggestions_on_situation_id"

  create_table "tag_to_situations", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "situation_id"
    t.integer  "score",        default: 100
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "tag_to_situations", ["situation_id"], name: "index_tag_to_situations_on_situation_id"
  add_index "tag_to_situations", ["tag_id"], name: "index_tag_to_situations_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "score",      default: 100
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "variables", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
