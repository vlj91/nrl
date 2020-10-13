class AddGameEventFields < ActiveRecord::Migration[6.0]
  def change
    add_column :game_events, :event_type, :string
    add_column :game_events, :name, :string
  end
end
