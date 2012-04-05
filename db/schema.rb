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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120402220823) do

  create_table "actions", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "movie_id"
    t.string   "fbid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "actions", ["movie_id"], :name => "index_actions_on_movie_id"
  add_index "actions", ["user_id"], :name => "index_actions_on_user_id"

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "poster"
    t.integer  "tmdb_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "movies", ["tmdb_id"], :name => "index_movies_on_tmdb_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.string   "facebook_id"
    t.string   "facebook_token"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id", :unique => true

end
