class CreateGameTeamPlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :game_team_players do |t|
      t.references :game_team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
