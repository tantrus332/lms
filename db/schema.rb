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

ActiveRecord::Schema[8.1].define(version: 2026_06_15_194155) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "course_students", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "role", default: 1, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["course_id"], name: "index_course_students_on_course_id"
    t.index ["user_id", "course_id"], name: "index_course_students_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_course_students_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "owner_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_courses_on_owner_id"
  end

  create_table "grades", force: :cascade do |t|
    t.text "comment"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "score", null: false
    t.bigint "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_grades_on_course_id"
    t.index ["student_id", "course_id"], name: "index_grades_on_student_id_and_course_id", unique: true
    t.index ["student_id"], name: "index_grades_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 2, null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "course_students", "courses"
  add_foreign_key "course_students", "users"
  add_foreign_key "courses", "users", column: "owner_id"
  add_foreign_key "grades", "courses"
  add_foreign_key "grades", "users", column: "student_id"
end
