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

ActiveRecord::Schema[8.0].define(version: 2018_09_04_143830) do
  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "milestones", force: :cascade do |t|
    t.integer "epic_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["epic_id"], name: "index_milestones_on_epic_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "notable_type"
    t.integer "notable_id"
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id"
  end

  create_table "positions", force: :cascade do |t|
    t.integer "employee_id"
    t.string "title"
    t.integer "historical_index"
    t.boolean "active"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "department_id"
    t.index ["department_id"], name: "index_positions_on_department_id"
    t.index ["employee_id"], name: "index_positions_on_employee_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "team_id"
    t.string "type"
    t.string "title"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["employee_id"], name: "index_tasks_on_employee_id"
    t.index ["team_id"], name: "index_tasks_on_team_id"
    t.index ["type"], name: "index_tasks_on_type"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.integer "team_id"
    t.integer "employee_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["employee_id"], name: "index_team_memberships_on_employee_id"
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "department_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["department_id"], name: "index_teams_on_department_id"
  end
end
