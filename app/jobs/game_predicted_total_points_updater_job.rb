class GamePredictedTotalPointsUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TotalPointsModel.build

    for game in Game.where(predicted_total_points: nil) do
      game.predicted_total_points = TotalPointsModel.predict(game)
      game.save!
    end
  end
end
