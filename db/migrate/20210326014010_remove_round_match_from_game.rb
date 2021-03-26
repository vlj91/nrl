class RemoveRoundMatchFromGame < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :round_match, :string
  end
end
