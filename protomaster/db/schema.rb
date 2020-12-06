# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_06_145721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "colordifferences", force: :cascade do |t|
    t.string "formtype"
    t.integer "proto_id"
    t.string "number"
    t.float "fullL"
    t.float "fulla"
    t.float "fullb"
    t.float "tintL"
    t.float "tinta"
    t.float "tintb"
    t.float "fulldL"
    t.float "fullda"
    t.float "fulldb"
    t.float "fulldE"
    t.float "tintdL"
    t.float "tintda"
    t.float "tintdb"
    t.float "tintdE"
    t.integer "user_id"
    t.date "measureDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "colorviewings", force: :cascade do |t|
    t.string "formtype"
    t.integer "proto_id"
    t.string "number"
    t.string "comp"
    t.float "fullcomp"
    t.float "fullcolor"
    t.float "tintcomp"
    t.float "tintcolor"
    t.float "tc_value"
    t.string "tc"
    t.integer "user_id"
    t.date "measureDate"
    t.string "thickness"
    t.string "temp"
    t.string "time"
    t.string "testShape"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "half_products", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.string "pigment"
    t.float "pigment_per"
    t.string "dispersant"
    t.float "dispersant_per"
    t.string "pigment2"
    t.float "pigment2_per"
    t.string "dispersant2"
    t.float "dispersant2_per"
    t.string "plasticizer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moisturevalues", force: :cascade do |t|
    t.string "formtype"
    t.integer "proto_id"
    t.string "number"
    t.date "measureDate"
    t.string "temp"
    t.string "time"
    t.float "endpoint"
    t.float "MV"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pigments", force: :cascade do |t|
    t.integer "code"
    t.string "name"
    t.string "maker"
    t.string "pig_no"
    t.string "structure"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prototype_names", force: :cascade do |t|
    t.string "name"
    t.string "formtype"
    t.integer "user_id"
    t.integer "client"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prototypes", force: :cascade do |t|
    t.integer "user_id"
    t.string "formtype"
    t.integer "name"
    t.string "number"
    t.text "conditions"
    t.string "particle"
    t.text "memo"
    t.integer "client"
    t.date "measureDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_user", default: 0
  end

  create_table "viscosities", force: :cascade do |t|
    t.string "formtype"
    t.integer "proto_id"
    t.string "number"
    t.string "temp"
    t.string "roter"
    t.integer "speed1"
    t.integer "speed2"
    t.integer "vs1"
    t.integer "vs2"
    t.integer "user_id"
    t.date "measureDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vrvalues", force: :cascade do |t|
    t.string "formtype"
    t.integer "proto_id"
    t.string "number"
    t.string "compname"
    t.float "comp"
    t.float "color"
    t.string "temp"
    t.string "time"
    t.float "brank"
    t.float "test"
    t.float "vr"
    t.integer "user_id"
    t.date "measureDate"
    t.float "thickness"
    t.integer "brank_expo"
    t.integer "test_expo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
