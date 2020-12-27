class RemoveResultColumnFromGame < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :result, :string
  end
end
