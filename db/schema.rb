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

ActiveRecord::Schema.define(version: 20150618215720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "general_settings", force: :cascade do |t|
    t.string   "title"
    t.string   "header"
    t.string   "subheader"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "nav"
    t.string   "slug"
    t.string   "external_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     limit: 255
    t.string   "slug",       limit: 255
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "display_name",    limit: 255
    t.string   "password_digest", limit: 255
    t.string   "role",            limit: 255
    t.string   "slug",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
