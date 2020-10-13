class Player < ApplicationRecord
  belongs_to :team
  has_many :game_events, through: :game

  def average_try_minute
    try_seconds = GameEvent.where(player_id: self.id, event_type: 'Try').map(&:game_seconds)

    try_seconds.sum.fdiv(try_seconds.size) / 60
  end

  def top_try_scorers
    GameEvent.where(event_type: 'Try')
  end

  def first_try_scorer
    GameEvent.where(event_type: 'Try', player_id: self.id)
  end
end
