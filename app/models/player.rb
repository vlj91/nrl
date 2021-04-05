class Player < ApplicationRecord
  has_many :game_events
  has_many :player_stats

  def tries
    game_events.where(event_type: 'Try')
  end

  def penalties
    game_events.where(event_type: 'Penalty')
  end

  def goals
    game_events.where(event_type: 'Goal')
  end

  def average_try_minute
    player_stats.find_by(name: 'average_try_minute').value
  end

  def average_tries_per_game
    player_stats.find_by(name: 'average_tries_per_game').value
  end
end
