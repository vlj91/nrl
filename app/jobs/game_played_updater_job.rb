class GamePlayedUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    updated_games = []

    for game in Game.all
      # less than or equal to current date isn't strictly reflective
      # of whether the game was played. we know that we'll only run
      # scrape jobs after all games in a current day have finished
      if game.kickoff_time.in_time_zone("Sydney") < Date.today
        game.played = true
        updated_games.push(game.id)
      else
        game.played = false
      end

      game.save!
    end

    logger.info("Updated games to played=true #{updated_games.join(',')}")
  end
end
