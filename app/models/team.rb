class Team < ApplicationRecord
  has_many :players
  has_many :games, through: :game_teams

  def slug
    self.name.downcase.gsub(" ", "-")
  end

  def stats
    {
      wins: self.wins.length,
      drawn: self.drawn.length,
      lost: self.lost.length,
      tries_per_game: self.tries_per_game
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

  def tries_per_game
    tries = GameEvent.where(team_id: self.id, event_type: 'Try').count

    return tries / self.games.length
  end

  def first_try_scorer
    all_first_try_scorer = Game.where(id: games).map(&:first_try_scorer_team_id)
    return all_first_try_scorer.count(self.id)
  end
end
