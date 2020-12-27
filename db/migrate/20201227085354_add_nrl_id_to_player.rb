class AddNrlIdToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :nrl_id, :integer
  end
end
