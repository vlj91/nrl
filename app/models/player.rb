class Player < ApplicationRecord
  belongs_to :team
  has_many :game_events, through: :game

  def stats
    {
      first_try_scorer: self.first_try_scorer.length,
      average_try_minute: self.average_try_minute.round(2)
    }
  end

  def team_name
    Team.find_by(id: self.team_id).name
  end

  def average_try_minute
    try_seconds = GameEvent.where(player_id: self.id, event_type: 'Try').map(&:game_seconds)

    try_seconds.sum.fdiv(try_seconds.size) / 60
  end

  def top_try_scorers
    GameEvent.where(event_type: 'Try')
  end

  def first_try_scorer
    Game.all.select { |i| i.first_try_scorer_player_id == self.id }
  end
end
