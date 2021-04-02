# TODO: make single controller for all predictions
class Api::V1::TotalTriesModelPredictionsController < ApplicationController
  def accuracy
    if params[:season] or params[:round]
      result = TotalTriesModel.new.accuracy({
        season: params[:season].split(','),
        round: params[:round].split(',')
      })
    else
      result = TotalTriesModel.new.accuracy
    end

    render :json => result
  end

  def show
  	game = Game.find(params[:id])
    result = TotalTriesModel.predict(game)

    render :json => result
  end
end
