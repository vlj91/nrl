class CreateGameEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :game_events do |t|
      t.string :type

      t.timestamps
    end
  end
end
