class CreateGameStats < ActiveRecord::Migration[6.0]
  def change
    create_table :game_stats do |t|
      t.references :game, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
