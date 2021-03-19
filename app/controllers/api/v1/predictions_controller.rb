class Api::V1::PredictionsController < ApplicationController
  # /api/v1/predictions/features
  def features
    render :json => ResultModel.new.feature_keys
  end

  # /api/v1/predictions/accuracy
  def accuracy
    if params[:season] && params[:round]
      result = ResultModel.new.accuracy(season: params[:season].split(','), round: params[:round].split(','))
    else
      result = ResultModel.new.accuracy
    end

    accuracy = (result[:accuracy] * 100).round(2)

    render :json => {"accuracy_percent": accuracy}
  end

  # /api/v1/predictions/probability/:id
  def probability
    probability = ResultModel.new.probability(Game.find(params[:id]))

    render :json => probability
  end

  # /api/v1/predictions/odds/:id
  def odds
    data = ResultModel.new.probability(Game.find(params[:id]))
    data['home'] = 1 / data['home']
    data['draw'] = 1 / data['draw']
    data['away'] = 1 / data['away']

    render :json => data
  end

  # /api/v1/predctions/:id
  def show
  	game = Game.find(params[:id])

  	render :json => {
      "predicted_result": game.predicted_result,
      "features": ResultModel.new.features(game)
    }
  end
end
