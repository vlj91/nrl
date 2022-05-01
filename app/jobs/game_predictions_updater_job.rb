class GamePredictionsUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    GamePredictedResultUpdaterJob.perform_now
    GamePredictedTotalTriesUpdaterJob.perform_now
    GamePredictedTotalPointsUpdaterJob.perform_now
    GamePredictedWinMarginUpdaterJob.perform_now
  end
end
