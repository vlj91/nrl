class PostGameJob < ApplicationJob
  queue_as :default

  def perform(*args)
    GamePlayedUpdaterJob.perform_now
    GameStatsScraperJob.perform_now
    GameResultUpdaterJob.perform_now
    GameStatsUpdaterJob.perform_now
    PlayerStatsUpdaterJob.perform_now
    TeamStatsUpdaterJob.perform_now
    GamePredictedWinMarginUpdaterJob.perform_now
    GamePredictedResultUpdaterJob.perform_now
    GamePredictedTotalTriesUpdaterJob.perform_now
    GamePredictedTotalPointsUpdaterJob.perform_now
  end
end
