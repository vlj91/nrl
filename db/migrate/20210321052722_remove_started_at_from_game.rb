class RemoveStartedAtFromGame < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :started_at, :string
  end
end
