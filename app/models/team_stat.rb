class TeamStat < ApplicationRecord
  belongs_to :team

  after_create_commit { 
    broadcast_prepend_to "team_stats"
  }

  after_update_commit {
    broadcast_replace_to "team_stats"
  }

  after_destroy_commit { 
    broadcast_remove_to "team_stats"
  }
end
