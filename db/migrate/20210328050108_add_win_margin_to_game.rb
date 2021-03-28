class AddWinMarginToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :win_margin, :integer
  end
end
