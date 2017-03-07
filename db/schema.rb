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

ActiveRecord::Schema.define(version: 20161014045749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "corrector_id",                    default: 0
    t.integer  "homework_id"
    t.text     "phase"
    t.text     "responder"
    t.text     "argumentar"
    t.text     "rehacer"
    t.text     "evaluar"
    t.text     "integrar"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "image_responder_1_file_name"
    t.string   "image_responder_1_content_type"
    t.integer  "image_responder_1_file_size"
    t.datetime "image_responder_1_updated_at"
    t.string   "image_responder_2_file_name"
    t.string   "image_responder_2_content_type"
    t.integer  "image_responder_2_file_size"
    t.datetime "image_responder_2_updated_at"
    t.string   "image_argumentar_1_file_name"
    t.string   "image_argumentar_1_content_type"
    t.integer  "image_argumentar_1_file_size"
    t.datetime "image_argumentar_1_updated_at"
    t.string   "image_argumentar_2_file_name"
    t.string   "image_argumentar_2_content_type"
    t.integer  "image_argumentar_2_file_size"
    t.datetime "image_argumentar_2_updated_at"
    t.string   "image_rehacer_1_file_name"
    t.string   "image_rehacer_1_content_type"
    t.integer  "image_rehacer_1_file_size"
    t.datetime "image_rehacer_1_updated_at"
    t.string   "image_rehacer_2_file_name"
    t.string   "image_rehacer_2_content_type"
    t.integer  "image_rehacer_2_file_size"
    t.datetime "image_rehacer_2_updated_at"
    t.string   "image_evaluar_1_file_name"
    t.string   "image_evaluar_1_content_type"
    t.integer  "image_evaluar_1_file_size"
    t.datetime "image_evaluar_1_updated_at"
    t.string   "image_evaluar_2_file_name"
    t.string   "image_evaluar_2_content_type"
    t.integer  "image_evaluar_2_file_size"
    t.datetime "image_evaluar_2_updated_at"
    t.string   "image_integrar_1_file_name"
    t.string   "image_integrar_1_content_type"
    t.integer  "image_integrar_1_file_size"
    t.datetime "image_integrar_1_updated_at"
    t.string   "image_integrar_2_file_name"
    t.string   "image_integrar_2_content_type"
    t.integer  "image_integrar_2_file_size"
    t.datetime "image_integrar_2_updated_at"
  end

  add_index "answers", ["user_id", "homework_id"], name: "index_answers_on_user_id_and_homework_id", using: :btree

  create_table "content_choices", force: :cascade do |t|
    t.text     "text"
    t.boolean  "right"
    t.integer  "content_question_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "content_choices", ["content_question_id"], name: "index_content_choices_on_content_question_id", using: :btree

  create_table "content_questions", force: :cascade do |t|
    t.text     "question"
    t.integer  "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  add_index "content_questions", ["tree_id"], name: "index_content_questions_on_tree_id", using: :btree

  create_table "contents", force: :cascade do |t|
    t.string   "text"
    t.integer  "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contents", ["tree_id"], name: "index_contents_on_tree_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "course_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  add_index "courses_users", ["course_id", "user_id"], name: "index_courses_users_on_course_id_and_user_id", using: :btree

  create_table "ct_choices", force: :cascade do |t|
    t.text     "text"
    t.boolean  "right"
    t.integer  "ct_question_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "ct_choices", ["ct_question_id"], name: "index_ct_choices_on_ct_question_id", using: :btree

  create_table "ct_habilities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "active"
    t.integer  "ct_question_id"
  end

  add_index "ct_habilities", ["ct_question_id"], name: "index_ct_habilities_on_ct_question_id", using: :btree

  create_table "ct_questions", force: :cascade do |t|
    t.text     "question"
    t.integer  "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  add_index "ct_questions", ["tree_id"], name: "index_ct_questions_on_tree_id", using: :btree

  create_table "ct_subhabilities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "ct_hability_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "ct_subhabilities", ["ct_hability_id"], name: "index_ct_subhabilities_on_ct_hability_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text     "text"
    t.integer  "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  add_index "feedbacks", ["tree_id"], name: "index_feedbacks_on_tree_id", using: :btree

  create_table "homeworks", force: :cascade do |t|
    t.text     "name"
    t.text     "content"
    t.integer  "actual_phase"
    t.boolean  "upload"
    t.boolean  "current"
    t.boolean  "partners"
    t.integer  "course_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "homeworks_users", id: false, force: :cascade do |t|
    t.integer "homework_id"
    t.integer "user_id"
  end

  add_index "homeworks_users", ["homework_id", "user_id"], name: "index_homeworks_users_on_homework_id_and_user_id", using: :btree

  create_table "registers", force: :cascade do |t|
    t.integer  "button_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trees", force: :cascade do |t|
    t.string   "video"
    t.integer  "iterations"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trees", ["course_id"], name: "index_trees_on_course_id", using: :btree

  create_table "user_tree_performances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tree_id"
    t.float    "content_sc"
    t.float    "interpretation_sc"
    t.float    "analysis_sc"
    t.float    "evaluation_sc"
    t.float    "inference_sc"
    t.float    "explanation_sc"
    t.float    "selfregulation_sc"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.float    "init_content"
    t.float    "init_ct"
    t.float    "recuperative_content1"
    t.float    "recuperative_content2"
    t.float    "recuperative_ct1"
    t.float    "recuperative_ct2"
    t.float    "deeping_content1"
    t.float    "deeping_content2"
    t.float    "deeping_ct1"
    t.float    "deeping_ct2"
    t.datetime "start_tree_time"
    t.datetime "finish_tree_time"
    t.float    "init_qt_time"
    t.float    "init_fb_time"
    t.float    "recuperative_qt1_time"
    t.float    "recuperative_qt2_time"
    t.float    "recuperative_fb1_time"
    t.float    "recuperative_fb2_time"
    t.float    "deeping_qt1_time"
    t.float    "deeping_qt2_time"
    t.float    "deeping_fb1_time"
    t.float    "deeping_fb2_time"
    t.integer  "total_time"
  end

  add_index "user_tree_performances", ["tree_id"], name: "index_user_tree_performances_on_tree_id", using: :btree
  add_index "user_tree_performances", ["user_id"], name: "index_user_tree_performances_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role"
    t.boolean  "asistencia"
    t.integer  "partner_id"
    t.integer  "corrector"
    t.integer  "corregido"
    t.integer  "current_course_id",      default: 0
    t.datetime "last_asistencia",        default: '2016-01-01 12:00:00'
    t.integer  "last_homework"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "email",                  default: "",                    null: false
    t.string   "encrypted_password",     default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_courses", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  add_index "users_courses", ["user_id", "course_id"], name: "index_users_courses_on_user_id_and_course_id", using: :btree

  add_foreign_key "content_choices", "content_questions"
  add_foreign_key "content_questions", "trees"
  add_foreign_key "contents", "trees"
  add_foreign_key "ct_choices", "ct_questions"
  add_foreign_key "ct_habilities", "ct_questions"
  add_foreign_key "ct_questions", "trees"
  add_foreign_key "ct_subhabilities", "ct_habilities"
  add_foreign_key "feedbacks", "trees"
  add_foreign_key "trees", "courses"
  add_foreign_key "user_tree_performances", "trees"
  add_foreign_key "user_tree_performances", "users"
end
