class GamePredictionUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    games = Game.all.where(predicted_result: nil).as_json
  end
end
