class Team < ApplicationRecord
  has_many :players
  has_many :game_teams
  has_many :games, through: :game_teams
  has_many :team_stats

  def game_first_tries
    team_stats.find_by(name: 'total_game_first_tries').value
  end

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

  def points_for
  end

  def points_against
  end

  def avg_win_margin
    TeamStat.find_by(team_id: self.id, name: 'avg_win_margin').value
  end

  def avg_loss_margin
    TeamStat.find_by(team_id: self.id, name: 'avg_loss_margin').value
  end

  def home_game_wins
    home_wins = 0
    gt = GameTeam.where(team_id: self.id, side: 'home')

    for g in gt do
      game = Game.find(g.game_id)
      home_wins += 1 if game.result == 'home'
    end

    home_wins
  end
  
  def away_game_wins
    away_wins = 0
    gt = GameTeam.where(team_id: self.id, side: 'away')

    for g in gt do
      game = Game.find(g.game_id)
      away_wins += 1 if game.result == 'away'
    end

    away_wins
  end

  # TODO: cleanup
  def wins
    wins = 0
    gt = GameTeam.where(team_id: self.id)

    for g in gt do
      game = Game.find(g.game_id)
      wins += 1 if game.result == g.side
    end

    wins
  end

  # TODO: cleanup
  def draws
    draws = 0
    gt = GameTeam.where(team_id: self.id)

    for g in gt do
      game = Game.find(g.game_id)
      draws += 1 if game.result == 'draw'
    end

    wins
  end

  # TODO: cleanup
  def losses
    losses = 0
    gt = GameTeam.where(team_id: self.id)

    for g in gt do
      opp_side = g.side == 'home' ? 'away' : 'home'
      game = Game.find(g.game_id)
      losses += 1 if game.result == opp_side
    end

    losses
  end
end
