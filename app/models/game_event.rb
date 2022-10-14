# == Schema Information
#
# Table name: game_events
#
#  id           :integer          not null, primary key
#  description  :text
#  event_type   :string
#  game_seconds :integer
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  game_id      :integer          not null
#  player_id    :integer          not null
#  team_id      :integer          not null
#
# Indexes
#
#  index_game_events_on_game_id    (game_id)
#  index_game_events_on_player_id  (player_id)
#  index_game_events_on_team_id    (team_id)
#
# Foreign Keys
#
#  game_id    (game_id => games.id)
#  player_id  (player_id => players.id)
#  team_id    (team_id => teams.id)
#
class GameEvent < ApplicationRecord
  belongs_to :game
end
