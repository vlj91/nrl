class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.references :team, null: false, foreign_key: true
      t.string :nrl_id

      t.timestamps
    end
  end
end
