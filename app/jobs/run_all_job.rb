class RunAllJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TeamScraperJob.perform_now
    PlayerScraperJob.perform_now
    GameScraperJob.perform_now
    GamePlayedUpdaterJob.perform_now
    GameStatsScraperJob.perform_now
    GameResultUpdaterJob.perform_now

    GameStatsUpdaterJob.perform_now
    PlayerStatsUpdaterJob.perform_now
    TeamStatsUpdaterJob.perform_now

    GamePredictedResultUpdaterJob.perform_now
    GamePredictedWinMarginUpdaterJob.perform_now
  end
end
