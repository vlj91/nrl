# == Schema Information
#
# Table name: game_stats
#
#  id         :integer          not null, primary key
#  name       :string
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer          not null
#  team_id    :integer          not null
#
# Indexes
#
#  index_game_stats_on_game_id  (game_id)
#  index_game_stats_on_team_id  (team_id)
#
# Foreign Keys
#
#  game_id  (game_id => games.id)
#  team_id  (team_id => teams.id)
#
class GameStat < ApplicationRecord
  belongs_to :game
  belongs_to :team
end
