class Player < ApplicationRecord
  has_many :game_events
  has_many :player_stats

  after_create_commit { 
    broadcast_prepend_to "players"
  }

  after_update_commit {
    broadcast_replace_to "players"
  }

  after_destroy_commit { 
    broadcast_remove_to "players"
  }

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
