class GameTeam < ApplicationRecord
  belongs_to :team
  belongs_to :game
end
