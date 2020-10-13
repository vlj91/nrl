class GameTeam < ApplicationRecord
  belongs_to :game
  belongs_to :team
end
