class Team < ApplicationRecord
  has_many :game_teams
  has_many :games, through: :game_teams
  has_many :players, through: :game_teams
  has_many :team_stats
  has_many :game_events

  def game_first_tries
    team_stats.find_by(name: 'total_game_first_tries').value
  end

  def avg_errors_per_game
    team_stats.find_by(team_id: self.id, name: 'avg_errors_per_game').value
  end

  def avg_tries_per_game
    team_stats.find_by(team_id: self.id, name: 'avg_tries_per_game').value
  end

  def avg_goals_per_game
    team_stats.find_by(team_id: self.id, name: 'avg_goals_per_game').value
  end

  def avg_line_breaks_per_game
    team_stats.find_by(team_id: self.id, name: 'avg_line_breaks_per_game').value
  end

  def total_tries
    team_stats.find_by(team_id: self.id, name: 'total_tries').value
  end

  def total_goals
    team_stats.find_by(team_id: self.id, name: 'total_goals').value
  end

  def total_errors
    team_stats.find_by(team_id: self.id, name: 'total_errors').value
  end

  def total_penalties
    team_stats.find_by(team_id: self.id, name: 'total_penalties').value
  end

  def total_line_breaks
    team_stats.find_by(team_id: self.id, name: 'total_line_breaks').value
  end

  def points_for
  end

  def points_against
  end

  def avg_win_margin
    team_stats.find_by(team_id: self.id, name: 'avg_win_margin').value
  end

  def avg_loss_margin
    team_stats.find_by(team_id: self.id, name: 'avg_loss_margin').value
  end

  def home_game_wins
    home_wins = 0

    for i in game_teams.where(side: 'home') do
      home_wins += 1 if i.game.result == 'home'
    end

    home_wins
  end
  
  def away_game_wins
    away_wins = 0

    for i in game_teams.where(side: 'away') do
      away_wins += 1 if i.game.result == 'away'
    end

    away_wins
  end

  # TODO: cleanup
  def wins
    wins = 0

    for i in game_teams do
      wins += 1 if i.game.result == i.side
    end

    wins
  end

  # TODO: cleanup
  def draws
    draws = 0

    for i in game_teams do
      draws += 1 if i.game.result == 'draw'
    end

    wins
  end

  # TODO: cleanup
  def losses
    losses = 0

    for i in game_teams do
      opp_side = i.side == 'home' ? 'away' : 'home'
      losses += 1 if i.game.result == opp_side
    end

    losses
  end
end
