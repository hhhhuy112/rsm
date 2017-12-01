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

ActiveRecord::Schema.define(version: 20171201014822) do

  create_table "achievements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "majors"
    t.string "organization"
    t.date "received_time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_achievements_on_name"
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "applies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_applies_on_job_id"
    t.index ["user_id", "job_id"], name: "index_applies_on_user_id_and_job_id", unique: true
    t.index ["user_id"], name: "index_applies_on_user_id"
  end

  create_table "appointments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "address"
    t.date "time"
    t.bigint "user_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_appointments_on_company_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "bookmark_likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "bookmark", default: 0
    t.bigint "user_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_bookmark_likes_on_job_id"
    t.index ["user_id", "job_id", "bookmark"], name: "index_bookmark_likes_on_user_id_and_job_id_and_bookmark", unique: true
    t.index ["user_id"], name: "index_bookmark_likes_on_user_id"
  end

  create_table "certificates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "majors"
    t.string "organization"
    t.string "classification"
    t.date "received_time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_certificates_on_name"
    t.index ["user_id"], name: "index_certificates_on_user_id"
  end

  create_table "clubs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "position", null: false
    t.date "start_time"
    t.date "end_time"
    t.text "content"
    t.boolean "current", default: false
    t.index ["name"], name: "index_clubs_on_name"
    t.index ["user_id"], name: "index_clubs_on_user_id"
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "address"
    t.string "phone"
    t.string "majors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_person"
    t.text "company_info"
    t.string "logo"
    t.string "banner"
    t.string "url_company"
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "experiences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "company"
    t.date "start_time"
    t.date "end_time"
    t.text "project_detail"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_experiences_on_name"
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_feedbacks_on_job_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "friends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "status"
    t.integer "friend_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id", "user_id"], name: "index_friends_on_friend_id_and_user_id", unique: true
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.string "name"
    t.string "level"
    t.string "language"
    t.string "skill"
    t.string "position"
    t.text "description"
    t.bigint "user_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "min_salary", limit: 24
    t.float "max_salary", limit: 24
    t.index ["company_id"], name: "index_jobs_on_company_id"
    t.index ["name"], name: "index_jobs_on_name"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "position"
    t.date "start_time"
    t.date "end_time"
    t.bigint "company_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "user_id"], name: "index_members_on_company_id_and_user_id", unique: true
    t.index ["company_id"], name: "index_members_on_company_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "microposts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.string "picture"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.boolean "status"
    t.integer "type"
    t.integer "url_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "project_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "status"
    t.bigint "member_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id", "project_id"], name: "index_project_members_on_member_id_and_project_id", unique: true
    t.index ["member_id"], name: "index_project_members_on_member_id"
    t.index ["project_id"], name: "index_project_members_on_project_id"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "info"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["name"], name: "index_projects_on_name"
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "type"
    t.text "reason"
    t.integer "reporter_id"
    t.integer "reported_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reported_id"], name: "index_reports_on_reported_id"
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
  end

  create_table "reward_benefits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_reward_benefits_on_job_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.date "birthday"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.integer "sex"
    t.integer "role", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "achievements", "users"
  add_foreign_key "applies", "jobs"
  add_foreign_key "applies", "users"
  add_foreign_key "appointments", "companies"
  add_foreign_key "appointments", "users"
  add_foreign_key "bookmark_likes", "jobs"
  add_foreign_key "bookmark_likes", "users"
  add_foreign_key "certificates", "users"
  add_foreign_key "clubs", "users"
  add_foreign_key "experiences", "users"
  add_foreign_key "feedbacks", "jobs"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "jobs", "companies"
  add_foreign_key "jobs", "users"
  add_foreign_key "members", "companies"
  add_foreign_key "members", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "project_members", "members"
  add_foreign_key "project_members", "projects"
  add_foreign_key "projects", "companies"
  add_foreign_key "reward_benefits", "jobs"
end
