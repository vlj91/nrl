class GamePredictedWinMarginUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    WinMarginModel.build
    
    for game in Game.where(predicted_win_margin: nil) do
      game.predicted_win_margin = WinMarginModel.predict(game)
      game.save!
    end
  end
end
