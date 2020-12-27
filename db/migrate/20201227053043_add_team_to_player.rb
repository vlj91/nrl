class AddTeamToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_reference :players, :team, null: false, foreign_key: true
  end
end
