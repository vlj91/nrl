class AddRoundToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :round, :integer
  end
end
