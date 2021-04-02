class GamePredictedTotalTriesUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TotalTriesModel.build

    for game in Game.where(predicted_total_tries: nil) do
      game.predicted_total_tries = TotalTriesModel.predict(game)
      game.save!
    end
  end
end
