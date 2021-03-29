class Api::V1::WinMarginModelPredictionsController < ApplicationController
  def accuracy
    game = Game.all
    game = game.where(season: params[:season]) if params[:season]
    game = game.where(round: params[:round]) if params[:round]

    result = WinMarginModel.new.accuracy(game)

    accuracy = (result[:accuracy] * 100).round(2)
    render :json => accuracy
  end

  def show
  	game = Game.find(params[:id])

    render :json => {
      "predicted_win_margin": game.predicted_win_margin
    }
  end
end
