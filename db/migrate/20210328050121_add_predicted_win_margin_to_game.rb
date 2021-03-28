class AddPredictedWinMarginToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :predicted_win_margin, :integer
  end
end
