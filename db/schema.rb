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

ActiveRecord::Schema.define(version: 20191007210718) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "colleges", force: :cascade do |t|
    t.text "name"
    t.text "last_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "last_email"], name: "index_colleges_on_name_and_last_email"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_favorites_on_micropost_id"
    t.index ["user_id", "micropost_id"], name: "index_favorites_on_user_id_and_micropost_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "receive_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receive_user_id"], name: "index_messages_on_receive_user_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "micropost_genres", force: :cascade do |t|
    t.integer "micropost_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_micropost_genres_on_genre_id"
    t.index ["micropost_id", "genre_id"], name: "index_micropost_genres_on_micropost_id_and_genre_id", unique: true
    t.index ["micropost_id"], name: "index_micropost_genres_on_micropost_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.integer "price"
    t.integer "cost"
    t.boolean "sold", default: false
    t.string "name"
    t.string "picture_1"
    t.string "picture_2"
    t.string "picture_3"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visiter_id"
    t.integer "visited_id"
    t.integer "micropost_id"
    t.integer "message_id"
    t.string "action"
    t.boolean "checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["micropost_id"], name: "index_notifications_on_micropost_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visiter_id"], name: "index_notifications_on_visiter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "picture"
    t.string "uid"
    t.string "provider"
    t.string "gender"
    t.string "grade"
    t.integer "college_id"
    t.integer "role", default: 1
    t.text "description"
    t.index ["college_id"], name: "index_users_on_college_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
