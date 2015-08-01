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

ActiveRecord::Schema.define(version: 20150726133457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "notifications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "recipient_id"
    t.uuid     "target_id"
    t.string   "target_type"
    t.boolean  "unread",       default: true
    t.string   "type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "notifications", ["recipient_id"], name: "index_notifications_on_recipient_id", using: :btree
  add_index "notifications", ["target_type", "target_id"], name: "index_notifications_on_target_type_and_target_id", using: :btree

  create_table "open_graph_caches", force: :cascade do |t|
    t.string   "title"
    t.string   "ob_type"
    t.string   "image"
    t.string   "url"
    t.string   "url_stripped"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "posts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id",                             null: false
    t.boolean  "public",              default: false, null: false
    t.text     "text"
    t.integer  "likes_count",         default: 0
    t.integer  "comments_count",      default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "open_graph_cache_id"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "auth_token",              default: "", null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "username_lower"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.string   "photo_fingerprint"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
