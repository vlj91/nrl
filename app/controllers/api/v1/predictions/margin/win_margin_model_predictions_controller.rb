# TODO: make single controller for all predictions
class Api::V1::Predictions::Margin::WinMarginModelPredictionsController < ApplicationController
  def accuracy
    game = Game.all
    game = game.where(season: params[:season]) if params[:season]
    game = game.where(round: params[:round]) if params[:round]

    result = WinMarginModel.new.accuracy(game)

    render :json => accuracy
  end

  def show
  	game = Game.find(params[:id])

    render :json => {
      "predicted_win_margin": game.predicted_win_margin
    }
  end
end
