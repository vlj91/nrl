class AddPredictedResultToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :predicted_result, :string
  end
end
