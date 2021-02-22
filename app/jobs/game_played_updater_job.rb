class GamePlayedUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    current_date = Date.today.strftime("%Y-%m-%D").to_date

    for game in Game.all
      # less than or equal to current date isn't strictly reflective
      # of whether the game was played. we know that we'll only run
      # scrape jobs after all games in a current day have finished
      if game.date.to_date <= current_date
        game.played = true
      else
        game.played = false
      end

      game.save!
    end
  end
end
