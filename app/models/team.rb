class Team < ApplicationRecord
  has_many :players
  has_many :game_teams
  has_many :games, through: :game_teams
  has_many :team_stats

  def avg_errors_per_game
    TeamStat.find_by(team_id: self.id, name: 'avg_errors_per_game').value
  end

  def avg_tries_per_game
    TeamState.find_by(team_id: self.id, name: 'avg_tries_per_game').value
  end
end
