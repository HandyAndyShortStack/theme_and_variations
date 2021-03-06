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

ActiveRecord::Schema.define(:version => 20131108181851) do

  create_table "blocks", :force => true do |t|
    t.text     "options"
    t.integer  "sandbox_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type"
  end

  create_table "pages", :force => true do |t|
    t.integer  "site_id"
    t.text     "options"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "template_id"
    t.string   "url"
    t.string   "title"
  end

  create_table "sandboxes", :force => true do |t|
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "sites", :force => true do |t|
    t.string   "subdomain"
    t.integer  "theme_id"
    t.text     "options"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "templates", :force => true do |t|
    t.integer  "theme_id"
    t.text     "liquid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "path"
  end

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "uri"
    t.text     "styles"
    t.text     "javascripts"
    t.text     "layout"
    t.text     "images"
    t.string   "type"
  end

end
