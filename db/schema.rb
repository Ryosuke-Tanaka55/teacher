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

ActiveRecord::Schema.define(version: 20210829135502) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_grade"
    t.string "second_grade"
    t.string "third_grade"
    t.string "fourth_grade"
    t.string "fifth_grade"
    t.string "sixth_grade"
    t.boolean "first_teacher", default: false
    t.boolean "second_teacher", default: false
    t.boolean "student", default: false
    t.string "status", default: "f"
    t.string "lunch_check_superior"
    t.boolean "superior_checker"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "school_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "student_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.string "teacher_of_student"
    t.string "student_classroom"
    t.string "alergy"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "classroom"
    t.datetime "basic_time", default: "2021-09-01 23:00:00"
    t.datetime "work_time", default: "2021-09-01 22:30:00"
    t.boolean "superior", default: false
    t.string "department"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["school_id"], name: "index_users_on_school_id"
  end

end
