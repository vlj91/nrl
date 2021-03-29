# TODO: make single controller for all predictions
class Api::V1::Predictions::Result::ResultModelPredictionsController < ApplicationController
  def features
    render :json => ResultModel.new.feature_keys
  end

  def accuracy
    game = Game.all
    game = game.where(season: params[:season].split(',')) if params[:season]
    game = game.where(round: params[:round].split(',')) if params[:round]
    result = ResultModel.new.accuracy(game)

    accuracy = (result[:accuracy] * 100).round(2)

    render :json => {
      accuracy_percent: accuracy,
      game_count: game.count
    }
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
