class GamePredictedResultUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    games = Game.all
    ResultModel.build

    for game in games do
      game.predicted_result = ResultModel.predict(game)
      game.save!
    end
  end
end
