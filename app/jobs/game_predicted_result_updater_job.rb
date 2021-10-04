class GamePredictedResultUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ResultModel.build

    for game in Game.where(predicted_result: [nil, 'draw']) do
      puts "Updating game: #{game}"
      game.predicted_result = ResultModel.predict(game)
      game.save!
    end
  end
end
