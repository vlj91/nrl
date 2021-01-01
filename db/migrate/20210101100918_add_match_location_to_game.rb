class AddMatchLocationToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :stadium, :string
    add_column :games, :city, :string
  end
end
