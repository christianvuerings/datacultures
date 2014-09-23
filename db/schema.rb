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

ActiveRecord::Schema.define(version: 20140821230550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "reason",                 null: false
    t.integer  "delta",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "canvas_user_id",         null: false
    t.integer  "canvas_scoring_item_id", null: false
    t.datetime "canvas_updated_at"
    t.text     "body"
    t.boolean  "score"
  end

  add_index "activities", ["canvas_scoring_item_id", "reason"], name: "index_activities_on_canvas_scoring_item_id_and_reason", using: :btree
  add_index "activities", ["deleted_at"], name: "index_activities_on_deleted_at", using: :btree

  create_table "attachments", force: true do |t|
    t.integer  "canvas_user_id"
    t.integer  "assignment_id"
    t.integer  "submission_id"
    t.integer  "attachment_id"
    t.string   "author"
    t.string   "date"
    t.string   "content_type"
    t.text     "url"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_comments"
  end

  create_table "comments", force: true do |t|
    t.integer  "parent_id",         null: false
    t.integer  "comment_id",        null: false
    t.text     "content"
    t.integer  "submission_id",     null: false
    t.integer  "authors_canvas_id", null: false
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points_configurations", force: true do |t|
    t.string   "pcid",                             null: false
    t.string   "interaction",                      null: false
    t.integer  "points_associated",                null: false
    t.boolean  "active",            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer  "canvas_user_id",                 null: false
    t.string   "name",                           null: false
    t.string   "sortable_name",                  null: false
    t.integer  "sis_user_id",                    null: false
    t.string   "primary_email"
    t.string   "section",                        null: false
    t.boolean  "share",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["canvas_user_id"], name: "index_students_on_canvas_user_id", unique: true, using: :btree

end
