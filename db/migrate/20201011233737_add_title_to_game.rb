class AddTitleToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :title, :string
  end
end
