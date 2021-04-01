# TODO: make single controller for all predictions
class Api::V1::Predictions::Margin::WinMarginModelPredictionsController < ApplicationController
  def accuracy
    if params[:season] or params[:round]
      result = WinMarginModel.new.accuracy({
        season: params[:season].split(','),
        round: params[:round].split(',')
      })
    else
      result = WinMarginModel.new.accuracy
    end

    render :json => accuracy
  end

  def show
  	game = Game.find(params[:id])

    render :json => {
      "predicted_win_margin": game.predicted_win_margin
    }
  end
end
