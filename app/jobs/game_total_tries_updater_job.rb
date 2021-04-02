class GameTotalTriesUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    for game in Game.where(played: true, total_tries: nil) do
      home_team_tries = game.home_team_tries.count
      away_team_tries = game.away_team_tries.count
      game.total_tries = home_team_tries + away_team_tries
      game.save!
    end
  end
end
