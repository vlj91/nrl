class Api::V1::TotalPointsModelPredictionsController < ApplicationController
  def accuracy
    if params[:season] or params[:round]
      result = TotalPointsModel.new.accuracy({
        season: params[:season].split(','),
        round: params[:round].split(',')
      })
    else
      result = TotalPointsModel.new.accuracy
    end

    render :json => result
  end

  def show
    game = Game.find(params[:id])
    result = TotalPointsModel.predict(game)

    render :json => result
  end
end