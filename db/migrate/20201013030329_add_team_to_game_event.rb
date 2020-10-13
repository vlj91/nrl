class AddTeamToGameEvent < ActiveRecord::Migration[6.0]
  def change
    add_reference :game_events, :team, null: false, foreign_key: true
  end
end
