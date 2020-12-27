class Team < ApplicationRecord
  has_many :players
  has_many :game_teams
  has_many :games, through: :game_teams

  def stats
    {
      avg_errors_per_game: self.avg_errors_per_game,
      avg_tries_per_game: self.avg_tries_per_game
    }
  end

  def avg_errors_per_game
    errs = []
    game_ids = GameTeam.where(team_id: self.id).map(&:game_id)
    games = Game.where(id: game_ids)
    games.each do |game|
      errs.push(game.game_events.where(team_id: self.id, event_type: 'Error').count)
    end

    return errs.sum.fdiv(errs.size).round(0)
  end

  def avg_tries_per_game
    tries = []
    game_ids = GameTeam.where(team_id: self.id).map(&:game_id)
    games = Game.where(id: game_ids)
    games.each do |game|
      tries.push(game.game_events.where(team_id: self.id, event_type: 'Try').count)
    end

    return tries.sum.fdiv(tries.size).round(0)
  end
end
