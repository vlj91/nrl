class AddBadgeUrlToTeam < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :badge_url, :string
  end
end
