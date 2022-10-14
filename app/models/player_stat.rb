# == Schema Information
#
# Table name: player_stats
#
#  id         :integer          not null, primary key
#  name       :string
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer          not null
#
# Indexes
#
#  index_player_stats_on_player_id  (player_id)
#
# Foreign Keys
#
#  player_id  (player_id => players.id)
#
class PlayerStat < ApplicationRecord
  belongs_to :player
end
