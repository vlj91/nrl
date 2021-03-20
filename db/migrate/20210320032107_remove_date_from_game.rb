class RemoveDateFromGame < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :date, :string
  end
end
