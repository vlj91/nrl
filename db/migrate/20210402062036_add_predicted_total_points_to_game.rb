class AddPredictedTotalPointsToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :predicted_total_points, :integer
  end
end
