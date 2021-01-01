class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.string :key
      t.text :data

      t.timestamps
    end
    add_index :models, :key, unique: true
  end
end
