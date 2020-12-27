class AddNrlIdToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :nrl_id, :integer
  end
end
