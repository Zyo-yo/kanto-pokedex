# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_09_000400) do
  create_table "elemental_types", force: :cascade do |t|
    t.integer "source_id", null: false
    t.string "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_elemental_types_on_identifier", unique: true
    t.index ["source_id"], name: "index_elemental_types_on_source_id", unique: true
  end

  create_table "kanto_encounters", force: :cascade do |t|
    t.integer "pokemon_id", null: false
    t.integer "kanto_location_id", null: false
    t.string "game_version", null: false
    t.string "encounter_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kanto_location_id"], name: "index_kanto_encounters_on_kanto_location_id"
    t.index ["pokemon_id", "kanto_location_id", "game_version", "encounter_method"], name: "idx_on_pokemon_id_kanto_location_id_game_version_en_a9fcd312b9", unique: true
    t.index ["pokemon_id"], name: "index_kanto_encounters_on_pokemon_id"
  end

  create_table "kanto_locations", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.json "map_cells", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_kanto_locations_on_identifier", unique: true
  end

  create_table "pokemon", force: :cascade do |t|
    t.integer "dex_number", null: false
    t.string "identifier", null: false
    t.integer "height_dm", null: false
    t.integer "weight_hg", null: false
    t.integer "base_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dex_number"], name: "index_pokemon_on_dex_number", unique: true
    t.index ["identifier"], name: "index_pokemon_on_identifier", unique: true
  end

  create_table "pokemon_typings", force: :cascade do |t|
    t.integer "pokemon_id", null: false
    t.integer "elemental_type_id", null: false
    t.integer "slot", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["elemental_type_id"], name: "index_pokemon_typings_on_elemental_type_id"
    t.index ["pokemon_id", "elemental_type_id"], name: "index_pokemon_typings_on_pokemon_id_and_elemental_type_id", unique: true
    t.index ["pokemon_id", "slot"], name: "index_pokemon_typings_on_pokemon_id_and_slot", unique: true
    t.index ["pokemon_id"], name: "index_pokemon_typings_on_pokemon_id"
  end

  add_foreign_key "kanto_encounters", "kanto_locations"
  add_foreign_key "kanto_encounters", "pokemon"
  add_foreign_key "pokemon_typings", "elemental_types"
  add_foreign_key "pokemon_typings", "pokemon"
end
