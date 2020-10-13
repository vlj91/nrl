class AddGameSecondsToGameEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :game_events, :game_seconds, :integer
  end
end
