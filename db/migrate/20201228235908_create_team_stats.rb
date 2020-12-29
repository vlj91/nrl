class CreateTeamStats < ActiveRecord::Migration[6.0]
  def change
    create_table :team_stats do |t|
      t.string :name
      t.integer :value
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
