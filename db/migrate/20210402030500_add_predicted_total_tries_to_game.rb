class AddPredictedTotalTriesToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :predicted_total_tries, :integer
  end
end
