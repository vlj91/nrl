class AddRoundMatchNumberToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :round_match, :integer
  end
end
