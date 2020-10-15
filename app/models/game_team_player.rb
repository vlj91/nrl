class GameTeamPlayer < ApplicationRecord
  belongs_to :game_team
  belongs_to :player
end
