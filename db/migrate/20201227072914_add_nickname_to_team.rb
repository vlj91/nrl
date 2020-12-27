class AddNicknameToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :nickname, :string
  end
end
