class GameEvent < ApplicationRecord
  belongs_to :game
  belongs_to :player
  belongs_to :team
end
