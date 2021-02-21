class PredictionsController < ApplicationController
  # /predictions/features
  def features
    render :json => ResultModel.new.feature_keys
  end

  # /predictions/accuracy
  def accuracy
    accuracy = (ResultModel.new.accuracy[:accuracy] * 100).round(2)

    render :json => {"accuracy_percent": accuracy}
  end

  # /predictions/probability/:id
  def probability
    probability = ResultModel.new.probability(Game.find(params[:id]))

    render :json => probability
  end

  # /predictions/odds/:id
  def odds
    data = ResultModel.new.probability(Game.find(params[:id]))
    data['home'] = 1 / data['home']
    data['draw'] = 1 / data['draw']
    data['away'] = 1 / data['away']

    render :json => data
  end

  # /predictions/:season/:round
  def round
    predictions = []

    for game in Game.where(season: params[:season], round: params[:round]) do
      predictions.push({
        title: game.title,
        predicted_result: game.predicted_result,
        probability: ResultModel.new.probability(Game.find(game.id))
      })
    end

    render :json => {
      round: params[:round],
      season: params[:season],
      predictions: predictions
    }
  end

  # /predction/:id
  def show
  	game = Game.find(params[:id])
  	@prediction = ResultModel.new.predict(game)

  	render :json => {"predicted_winner": @prediction}
  end
end
