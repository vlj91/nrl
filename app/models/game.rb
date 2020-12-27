class Game < ApplicationRecord
  has_many :game_teams
  has_many :game_events

  def away_team
    GameTeam.find_by(game_id: self.id, side: 'away')
  end

  def home_team
    GameTeam.find_by(game_id: self.id, side: 'home')
  end
end
