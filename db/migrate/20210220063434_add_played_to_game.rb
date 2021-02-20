class AddPlayedToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :played, :boolean
  end
end
