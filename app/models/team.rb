class Team < ApplicationRecord
  has_many :players
  has_many :games, through: :game_teams
  before_save :add_slug

  def add_slug
    self.slug = self.name.downcase.gsub(" ", "-")
  end

  def played
    {
      wins: self.wins.length,
      drawn: self.drawn.length,
      lost: self.lost.length
    }
  end

  def stats
    {
      average_tries_per_game: self.average_tries_per_game,
      average_total_points_per_game: self.average_total_points_per_game,
      average_team_points_per_game: self.average_points_per_game,
      number_first_game_tries: self.number_first_game_tries
    }
  end

  def info
    {
      played: played,
      stats: stats
    }
  end

  def games
    GameTeam.where(team_id: self.id).map(&:game_id)
  end

  def wins
    Game.where(id: games).select { |i| i.winner_id == self.id }
  end

  def drawn
    Game.where(id: games).select { |i| i.winner_id == i.loser_id }
  end

  def lost
    Game.where(id: games).select { |i| i.loser_id == self.id }
  end

  def average_tries_per_game
    tries = GameEvent.where(team_id: self.id, event_type: 'Try').count

    return tries / self.games.length
  end

  def average_total_points_per_game
    games = GameTeam.where(team_id: self.id).map(&:game_id)
    all_games_total_points = []

    games.each do |game|
      game = Game.find_by(id: game)
      all_games_total_points.push(GameTeam.where(game_id: game.id).map(&:score).sum)
    end

    all_games_total_points.sum.fdiv(all_games_total_points.size).round(0)
  end

  def average_points_per_game
    games = GameTeam.where(team_id: self.id).map(&:game_id)
    all_games_points = []

    games.each do |game|
      game = Game.find_by(id: game)
      all_games_points.push(GameTeam.where(game_id: game.id, team_id: self.id).map(&:score).sum)
    end

    all_games_points.sum.fdiv(all_games_points.size).round(0)
  end

  def number_first_game_tries
    all_first_try_scorer = Game.where(id: games).map(&:first_try_scorer_team_id)
    return all_first_try_scorer.count(self.id)
  end

  def top_player_first_try_scorer
    self.players.sort_by { |i| i.first_try_scorer }.reverse.first 
  end

  def average_win_margin
    Games.where(id: [games], winner_id: self.id)
  end
end
