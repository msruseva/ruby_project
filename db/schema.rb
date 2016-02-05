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

ActiveRecord::Schema.define(version: 20160205161358) do

  create_table "parents", force: :cascade do |t|
    t.integer "user_id"
    t.integer "mother_id"
    t.string  "mother_first_name"
    t.string  "mother_second_name"
    t.string  "mother_last_name"
    t.integer "father_id"
    t.string  "father_first_name"
    t.string  "father_second_name"
    t.string  "father_last_name"
    t.string  "district_work"
    t.string  "mother_school"
    t.string  "father_school"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
  end

end
