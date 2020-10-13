class AddDescriptionToGameEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :game_events, :description, :text
  end
end
