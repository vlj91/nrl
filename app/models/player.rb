class Player < ApplicationRecord
  belongs_to :team
  has_many :game_events, through: :game

  def stats
    {
      first_try_scorer: self.first_try_scorer.length,
      tries: self.tries.count,
      goals: self.goals.length,
      missed_goals: self.missed_goals.length,
      errors: self.errors.length,
      sin_bins: self.sin_bins.length,
      average_try_minute: self.average_try_minute.round(2)
    }
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def team_name
    self.team.name
  end

  def average_try_minute
    try_seconds = GameEvent.where(player_id: self.id, event_type: 'Try').map(&:game_seconds)

    try_seconds.sum.fdiv(try_seconds.size) / 60
  end

  def first_try_scorer
    Game.all.select { |i| i.first_try_scorer_player_id == self.id }
  end

  def tries
    GameEvent.where(player_id: self.id, event_type: 'Try')
  end

  def goals
    GameEvent.where(player_id: self.id, event_type: 'Goal')
  end

  def missed_goals
    GameEvent.where(player_id: self.id, event_type: 'GoalMissed')
  end

  def errors
    GameEvent.where(player_id: self.id, event_type: 'Error')
  end

  def sin_bins
    GameEvent.where(player_id: self.id, event_type: 'SinBin')
  end
end
