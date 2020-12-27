class AddNameToGameEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :game_events, :name, :string
  end
end
