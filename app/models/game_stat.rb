class GameStat < ApplicationRecord
  belongs_to :game
  belongs_to :team

  after_create_commit { 
    broadcast_prepend_to "games"
  }

  after_update_commit { 
    broadcast_replace_to "games"
  }

  after_destroy_commit { 
    broadcast_remove_to "games"
  }
end
