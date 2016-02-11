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

ActiveRecord::Schema.define(version: 20160211134749) do

  create_table "applications", force: :cascade do |t|
    t.integer  "child_id"
    t.integer  "school_id"
    t.integer  "num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
    t.integer  "num_classifing"
    t.boolean  "classifing"
  end

  add_index "applications", ["child_id"], name: "index_applications_on_child_id"
  add_index "applications", ["school_id"], name: "index_applications_on_school_id"

  create_table "children", force: :cascade do |t|
    t.string  "egn"
    t.string  "first_name"
    t.string  "second_name"
    t.string  "last_name"
    t.boolean "group"
    t.boolean "orphan"
    t.boolean "half_orphan"
    t.boolean "parent_in_system"
    t.integer "parent_id"
    t.integer "district_id"
    t.integer "user_id"
  end

  add_index "children", ["district_id"], name: "index_children_on_district_id"
  add_index "children", ["parent_id"], name: "index_children_on_parent_id"
  add_index "children", ["user_id"], name: "index_children_on_user_id"

  create_table "districts", force: :cascade do |t|
    t.string "name"
  end

  create_table "parents", force: :cascade do |t|
    t.string  "mother_egn"
    t.string  "mother_first_name"
    t.string  "mother_second_name"
    t.string  "mother_last_name"
    t.string  "father_egn"
    t.string  "father_first_name"
    t.string  "father_second_name"
    t.string  "father_last_name"
    t.integer "mother_school_id"
    t.integer "father_school_id"
    t.integer "district_id"
    t.integer "user_id"
  end

  add_index "parents", ["district_id"], name: "index_parents_on_district_id"
  add_index "parents", ["father_school_id"], name: "index_parents_on_father_school_id"
  add_index "parents", ["mother_school_id"], name: "index_parents_on_mother_school_id"
  add_index "parents", ["user_id"], name: "index_parents_on_user_id"

  create_table "schools", force: :cascade do |t|
    t.integer  "district_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["district_id"], name: "index_schools_on_district_id"

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
  end

end
