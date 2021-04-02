class AddTotalPointsToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :total_points, :integer
  end
end
