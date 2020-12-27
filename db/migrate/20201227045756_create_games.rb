class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :date
      t.integer :started_at

      t.timestamps
    end
  end
end
