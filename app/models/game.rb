class Game < ApplicationRecord
  validates :result, inclusion: { in: %w[home, draw, away] }
end
