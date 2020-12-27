class Player < ApplicationRecord
  belongs_to :team
  has_many :game_events
end
