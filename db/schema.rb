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

ActiveRecord::Schema.define(version: 20150308193007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "citext"

  create_table "code_counts", force: :cascade do |t|
    t.integer "run_id",       null: false
    t.string  "directory",    null: false
    t.string  "language",     null: false
    t.string  "filename",     null: false
    t.integer "blanks",       null: false
    t.integer "comments",     null: false
    t.integer "lines",        null: false
    t.decimal "scale",        null: false
    t.decimal "scaled_lines", null: false
  end

  create_table "runs", force: :cascade do |t|
    t.string   "branch",     null: false
    t.datetime "from",       null: false
    t.string   "sha",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "code_counts", "runs", on_delete: :cascade
end
