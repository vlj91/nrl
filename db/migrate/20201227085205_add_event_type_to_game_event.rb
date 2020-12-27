class AddEventTypeToGameEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :game_events, :event_type, :string
  end
end
