class GamePredictedWinMarginUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "Building WinMargin model"
    WinMarginModel.build

    game = Game.all
    logger.info "Updating #{game.count} games"
    
    for game in Game.all do
      logger.info "Updating game #{game.id} (#{game.title})"
      game.predicted_win_margin = WinMarginModel.predict(game)
      game.save!
    end
  end
end
