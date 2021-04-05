# TODO: make single controller for all predictions
class Api::V1::ResultModelPredictionsController < ApplicationController
  def accuracy
    if params[:season] or params[:round]
      result = ResultModel.new.accuracy({
        season: params[:season].split(','),
        round: params[:round].split(',')
      })
    else
      result = ResultModel.new.accuracy
    end

    accuracy = (result[:accuracy] * 100).round(2) # do math things
    render :json => { "accuracy_percent": accuracy }
  end

  def probability
    probability = ResultModel.new.probability(Game.find(params[:id]))

    render :json => probability
  end

  def odds
    data = ResultModel.new.probability(Game.find(params[:id]))
    data['home'] = 1 / data['home']
    data['draw'] = 1 / data['draw']
    data['away'] = 1 / data['away']

    render :json => data
  end

  def show
  	game = Game.find(params[:id])

  	render :json => {
      "predicted_result": game.predicted_result,
      "features": ResultModel.new.features(game)
    }
  end
end
