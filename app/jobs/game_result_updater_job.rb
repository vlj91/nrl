class GameResultUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    for game in Game.all
      if game.home_team_points > game.away_team_points
        game.result = 'home'
        game.win_margin = game.home_team_points - game.away_team_points
      elsif game.away_team_points > game.home_team_points
        game.result = 'away'
        game.win_margin = game.away_team_points - game.home_team_points
      elsif game.home_team_points == game.away_team_points
        game.result = 'draw'
        game.win_margin = 0
      end

      game.save!
    end
  end
end
