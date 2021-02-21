class GamePredictionUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    games ||= Game.all.where(predicted_result: nil)
    # ensure the model is built
    ResultModel.build

    for game in games do
      current_prediction = game.predicted_result
      game.predicted_result = ResultModel.predict(game)
      game.save!

      if current_prediction != game.predicted_result
        logger.info "game #{game.id} changed predicted result from #{current_prediction} to #{game.predicted_result}"
      end
    end
  end
end
