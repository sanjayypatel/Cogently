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

ActiveRecord::Schema.define(version: 20151102193744) do

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
    t.integer  "user_id"
    t.text     "content"
  end

  add_index "documents", ["organization_id"], name: "index_documents_on_organization_id"
  add_index "documents", ["user_id"], name: "index_documents_on_user_id"

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "events", ["organization_id"], name: "index_events_on_organization_id"

  create_table "feeds", force: :cascade do |t|
    t.string   "tag"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id"

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "memberships", ["organization_id"], name: "index_memberships_on_organization_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "notes", force: :cascade do |t|
    t.string   "body"
    t.integer  "paragraph_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "notes", ["paragraph_id"], name: "index_notes_on_paragraph_id"
  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "moderator_id"
  end

  add_index "organizations", ["moderator_id"], name: "index_organizations_on_moderator_id"

  create_table "paragraphs", force: :cascade do |t|
    t.string   "content"
    t.integer  "document_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "paragraphs", ["document_id"], name: "index_paragraphs_on_document_id"

  create_table "summaries", force: :cascade do |t|
    t.text     "body"
    t.integer  "document_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "",      null: false
    t.string   "encrypted_password",      default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "role",                    default: "staff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",       default: 0
    t.integer  "invited_organization_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
