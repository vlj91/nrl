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

ActiveRecord::Schema.define(version: 2021_01_01_100918) do

  create_table "game_events", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "event_type"
    t.string "name"
    t.integer "game_id", null: false
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.text "description"
    t.integer "game_seconds"
    t.index ["game_id"], name: "index_game_events_on_game_id"
    t.index ["player_id"], name: "index_game_events_on_player_id"
    t.index ["team_id"], name: "index_game_events_on_team_id"
  end

  create_table "game_stats", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "team_id", null: false
    t.string "name"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_stats_on_game_id"
    t.index ["team_id"], name: "index_game_stats_on_team_id"
  end

  create_table "game_teams", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "game_id", null: false
    t.string "side"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_teams_on_game_id"
    t.index ["team_id"], name: "index_game_teams_on_team_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "date"
    t.integer "started_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "round"
    t.string "title"
    t.string "result"
    t.string "predicted_result"
    t.string "stadium"
    t.string "city"
  end

  create_table "models", force: :cascade do |t|
    t.string "key"
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key"], name: "index_models_on_key", unique: true
  end

  create_table "player_stats", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.integer "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_player_stats_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "team_id", null: false
    t.integer "nrl_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "team_stats", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.integer "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_stats_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.integer "nrl_id"
  end

  add_foreign_key "game_events", "games"
  add_foreign_key "game_events", "players"
  add_foreign_key "game_events", "teams"
  add_foreign_key "game_stats", "games"
  add_foreign_key "game_stats", "teams"
  add_foreign_key "game_teams", "games"
  add_foreign_key "game_teams", "teams"
  add_foreign_key "player_stats", "players"
  add_foreign_key "players", "teams"
  add_foreign_key "team_stats", "teams"
end
