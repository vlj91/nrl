class AddKickoffTimeToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :kickoff_time, :datetime
  end
end
