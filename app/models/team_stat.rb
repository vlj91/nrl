# == Schema Information
#
# Table name: team_stats
#
#  id         :integer          not null, primary key
#  name       :string
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer          not null
#
# Indexes
#
#  index_team_stats_on_team_id  (team_id)
#
# Foreign Keys
#
#  team_id  (team_id => teams.id)
#
class TeamStat < ApplicationRecord
  belongs_to :team
end
