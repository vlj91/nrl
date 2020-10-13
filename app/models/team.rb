class Team < ApplicationRecord
  has_many :players
  has_many :games, through: :game_teams

  def slug
    self.name.downcase.gsub(" ", "-")
  end
end
