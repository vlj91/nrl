class PredictionsController < ApplicationController
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
    probability = ResultModel.new.probability(Game.find(params[:id]))

    probability[:home] = 1 / (probability[:home] / 100)
    probability[:draw] = 1 / (probability[:draw] / 100)
    probability[:away] = 1 / (probability[:away] / 100)

    render :json => probability
  end

  # /predction/:id
  def show
  	game = Game.find(params[:id])
  	@prediction = ResultModel.new.predict(game)

  	render :json => {"predicted_winner": @prediction}
  end
end
