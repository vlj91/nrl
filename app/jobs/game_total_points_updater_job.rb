class GameTotalPointsUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    for game in Game.where(played: true, total_points: nil) do
      home_team_points = game.home_team_points
      away_team_points = game.away_team_points
      game.total_points = home_team_points + away_team_points
      game.save!
    end
  end
end
