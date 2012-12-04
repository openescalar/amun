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

ActiveRecord::Schema.define(:version => 20120604012608) do

  create_table "accounts", :force => true do |t|
    t.string   "key"
    t.string   "secret"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts_users", :id => false, :force => true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "azones", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "endpoint"
    t.integer  "zone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deployments", :force => true do |t|
    t.string   "serial"
    t.string   "name"
    t.string   "description"
    t.text     "definition"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deployments_servers", :id => false, :force => true do |t|
    t.integer  "deployment_id"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distros", :force => true do |t|
    t.string   "serial"
    t.string   "description"
    t.string   "arch"
    t.string   "url"
    t.integer  "zone_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "otype"
    t.string   "ntype"
    t.string   "status"
    t.text     "description"
    t.string   "server"
    t.string   "account"
    t.string   "user"
    t.string   "ident"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "firewalls", :force => true do |t|
    t.string   "serial"
    t.string   "name"
    t.string   "description"
    t.integer  "zone_id"
    t.integer  "azone_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "serial"
    t.string   "description"
    t.string   "arch"
    t.integer  "zone_id"
    t.integer  "azone_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infraescalas", :force => true do |t|
    t.string   "itype"
    t.string   "imodel"
    t.integer  "iactive"
    t.integer  "imax"
    t.integer  "ivote"
    t.integer  "iorig"
    t.integer  "iescalar"
    t.integer  "infrastructure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infrastructures", :force => true do |t|
    t.string   "serial"
    t.string   "name"
    t.string   "description"
    t.text     "definition"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loadbalancers", :force => true do |t|
    t.string   "serial"
    t.string   "description"
    t.integer  "port"
    t.integer  "serverport"
    t.string   "subzone"
    t.string   "protocol"
    t.integer  "zone_id"
    t.integer  "azone_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.integer  "zone_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "serial"
    t.string   "name"
    t.string   "description"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_servers", :id => false, :force => true do |t|
    t.integer  "role_id"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roletask_workflows", :force => true do |t|
    t.integer  "roletask_id"
    t.integer  "workflow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roletasks", :force => true do |t|
    t.string   "serial"
    t.string   "name"
    t.text     "content"
    t.integer  "account_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", :force => true do |t|
    t.string   "protocol"
    t.string   "port"
    t.string   "source"
    t.integer  "firewall_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "serial"
    t.string   "fqdn"
    t.boolean  "physical"
    t.string   "ip"
    t.string   "pip"
    t.integer  "zone_id"
    t.integer  "azone_id"
    t.integer  "offer_id"
    t.integer  "image_id"
    t.integer  "loadbalancer_id"
    t.integer  "firewall_id"
    t.integer  "account_id"
    t.integer  "infraescala_id"
    t.integer  "infrastructure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volumes", :force => true do |t|
    t.string   "serial"
    t.string   "description"
    t.integer  "size"
    t.string   "subzone"
    t.integer  "zone_id"
    t.integer  "azone_id"
    t.integer  "server_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.string   "serial"
    t.integer  "infraescala_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vpns", :force => true do |t|
    t.string   "serial"
    t.string   "description"
    t.string   "network"
    t.string   "netmask"
    t.integer  "client"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workflows", :force => true do |t|
    t.string   "serial"
    t.string   "name"
    t.string   "description"
    t.integer  "deployment_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "entrypoint"
    t.string   "apitype"
    t.string   "key"
    t.string   "secret"
    t.string   "tokenexp"
    t.string   "token"
    t.string   "tenant"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
