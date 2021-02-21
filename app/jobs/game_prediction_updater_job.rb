class GamePredictionUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    games ||= Game.all.where(predicted_result: nil)
    # ensure the model is built
    ResultModel.build

    for game in games do
      game.predicted_result = ResultModel.predict(game)
      game.save!
    end
  end
end
