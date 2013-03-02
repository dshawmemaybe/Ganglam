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

ActiveRecord::Schema.define(:version => 20130227070356) do

  create_table "charts", :force => true do |t|
    t.string   "song"
    t.string   "artist"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "city", :primary_key => "ID", :force => true do |t|
    t.string  "Name",        :limit => 35, :default => "", :null => false
    t.string  "CountryCode", :limit => 3,  :default => "", :null => false
    t.string  "District",    :limit => 20, :default => "", :null => false
    t.integer "Population",                :default => 0,  :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "country", :primary_key => "Code", :force => true do |t|
    t.string  "Name",           :limit => 52, :default => "",     :null => false
    t.string  "Continent",      :limit => 0,  :default => "Asia", :null => false
    t.string  "Region",         :limit => 26, :default => "",     :null => false
    t.float   "SurfaceArea",    :limit => 10, :default => 0.0,    :null => false
    t.integer "IndepYear",      :limit => 2
    t.integer "Population",                   :default => 0,      :null => false
    t.float   "LifeExpectancy", :limit => 3
    t.float   "GNP",            :limit => 10
    t.float   "GNPOld",         :limit => 10
    t.string  "LocalName",      :limit => 45, :default => "",     :null => false
    t.string  "GovernmentForm", :limit => 45, :default => "",     :null => false
    t.string  "HeadOfState",    :limit => 60
    t.integer "Capital"
    t.string  "Code2",          :limit => 2,  :default => "",     :null => false
  end

  create_table "countrylanguage", :id => false, :force => true do |t|
    t.string "CountryCode", :limit => 3,  :default => "",  :null => false
    t.string "Language",    :limit => 30, :default => "",  :null => false
    t.string "IsOfficial",  :limit => 0,  :default => "F", :null => false
    t.float  "Percentage",  :limit => 4,  :default => 0.0, :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string   "username"
    t.string   "monday"
    t.string   "tuesday"
    t.string   "wednesday"
    t.string   "thursday"
    t.string   "friday"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["post_id"], :name => "index_tags_on_post_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "lastname"
    t.string   "firstname"
    t.string   "email"
    t.integer  "schedule_id"
    t.integer  "group_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "users", ["group_id"], :name => "index_users_on_group_id"
  add_index "users", ["schedule_id"], :name => "index_users_on_schedule_id"

end
