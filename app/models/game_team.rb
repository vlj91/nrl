# == Schema Information
#
# Table name: game_teams
#
#  id         :integer          not null, primary key
#  side       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer          not null
#  team_id    :integer          not null
#
# Indexes
#
#  index_game_teams_on_game_id  (game_id)
#  index_game_teams_on_team_id  (team_id)
#
# Foreign Keys
#
#  game_id  (game_id => games.id)
#  team_id  (team_id => teams.id)
#
class GameTeam < ApplicationRecord
  belongs_to :team
  belongs_to :game
  has_many :players
end
