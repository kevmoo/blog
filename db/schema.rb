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

ActiveRecord::Schema.define(:version => 20101114004249) do

  create_table "blobs", :id => false, :force => true do |t|
    t.text   "value",               :null => false
    t.string "id",    :limit => 40, :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "version_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "blob_id",                               :null => false
    t.integer  "previous_id"
    t.text     "metadata",    :default => "--- {}\n\n", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
