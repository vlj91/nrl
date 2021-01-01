class Team < ApplicationRecord
  has_many :players
  has_many :game_teams
  has_many :games, through: :game_teams
  has_many :team_stats

  def avg_errors_per_game
    TeamStat.find_by(team_id: self.id, name: 'avg_errors_per_game').value
  end

  def avg_tries_per_game
    TeamStat.find_by(team_id: self.id, name: 'avg_tries_per_game').value
  end

  def avg_goals_per_game
    TeamStat.find_by(team_id: self.id, name: 'avg_goals_per_game').value
  end

  def avg_line_breaks_per_game
    TeamStat.find_by(team_id: self.id, name: 'avg_line_breaks_per_game').value
  end

  def total_tries
    TeamStat.find_by(team_id: self.id, name: 'total_tries').value
  end

  def total_goals
    TeamStat.find_by(team_id: self.id, name: 'total_goals').value
  end

  def total_errors
    TeamStat.find_by(team_id: self.id, name: 'total_errors').value
  end

  def total_penalties
    TeamStat.find_by(team_id: self.id, name: 'total_penalties').value
  end

  def total_line_breaks
    TeamStat.find_by(team_id: self.id, name: 'total_line_breaks').value
  end

  def wins
    wins = 0
    gt = GameTeam.where(team_id: self.id)

    for g in gt do
      game = Game.find_by(game_id: gt.game_id)

      wins += 1 if game.result == gt.side
    end

    wins
  end
end
