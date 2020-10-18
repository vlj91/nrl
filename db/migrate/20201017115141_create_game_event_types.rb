class CreateGameEventTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :game_event_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
