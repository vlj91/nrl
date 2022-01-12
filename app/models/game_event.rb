class GameEvent < ApplicationRecord
  belongs_to :game

  after_create_commit { 
    broadcast_prepend_to "game_events"
    broadcast_prepend_to(game, :game_events)
    broadcast_prepend_to "game_events_#{game_id}"
  }

  after_update_commit {
    broadcast_replace_to "game_events"
    broadcast_replace_to(game, :game_events)
    broadcast_replace_to "game_events_#{game_id}"
  }

  after_destroy_commit { 
    broadcast_remove_to "game_events"
    broadcast_remove_to(game, :game_events)
    broadcast_remove_to "game_events_#{game_id}"
  }
end
