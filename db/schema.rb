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

ActiveRecord::Schema[7.1].define(version: 2024_11_08_162740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
  end

  create_table "educations", force: :cascade do |t|
    t.string "diploma_name"
    t.string "institution_name"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.string "logo"
    t.bigint "resume_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "order_position"
    t.index ["resume_id"], name: "index_educations_on_resume_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "job_title"
    t.string "company_name"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.text "missions"
    t.bigint "resume_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.integer "order_position"
    t.index ["resume_id"], name: "index_experiences_on_resume_id"
  end

  create_table "project_technologies", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "technology_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_technologies_on_project_id"
    t.index ["technology_item_id"], name: "index_project_technologies_on_technology_item_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "pictures"
    t.string "technologies"
    t.integer "dev_count"
    t.string "link"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "features"
    t.text "frontend_technologies"
    t.text "backend_technologies"
    t.text "tools"
    t.string "subtitle"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "picture"
    t.string "pdf"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_resumes_on_user_id"
  end

  create_table "technology_items", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_position"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.text "bio"
    t.string "links"
    t.string "avatar"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "educations", "resumes"
  add_foreign_key "experiences", "resumes"
  add_foreign_key "project_technologies", "projects"
  add_foreign_key "project_technologies", "technology_items"
  add_foreign_key "projects", "users"
  add_foreign_key "resumes", "users"
end
