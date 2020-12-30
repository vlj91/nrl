class AddResultToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :result, :string
  end
end
