class PlayerStat < ApplicationRecord
  belongs_to :player

  after_create_commit { 
    broadcast_prepend_to "player_stats"
  }

  after_update_commit {
    broadcast_replace_to "player_stats"
  }

  after_destroy_commit { 
    broadcast_remove_to "player_stats"
  }
end
