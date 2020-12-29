class CreatePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stats do |t|
      t.string :name
      t.integer :value
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
