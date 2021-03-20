class AddScrapedToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :scraped, :boolean
  end
end
