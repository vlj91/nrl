# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  nrl_id     :integer
#  team_id    :integer          not null
#
# Indexes
#
#  index_players_on_team_id  (team_id)
#
# Foreign Keys
#
#  team_id  (team_id => teams.id)
#
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
