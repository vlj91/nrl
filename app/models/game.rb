class Game < ApplicationRecord
  has_many :game_teams
  has_many :game_events

  def home_team
    GameTeam.find_by(game_id: self.id, side: 'home')    
  end

  def away_team
    GameTeam.find_by(game_id: self.id, side: 'away')
  end

  def winner_id
    home_team.score > away_team.score ? home_team.id : away_team.id 
  end
end
