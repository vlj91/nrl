class AddTotalTriesToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :total_tries, :integer
  end
end
