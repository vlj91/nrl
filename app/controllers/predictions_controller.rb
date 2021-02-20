class PredictionsController < ApplicationController
  def accuracy
    accuracy = (ResultModel.new.accuracy[:accuracy] * 100).round(2)

    render :json => {"accuracy_percent": accuracy}
  end

  def show
  	game = Game.find(params[:id])
  	@prediction = ResultModel.new.predict(game)

  	render :json => {"predicted_winner": @prediction}
  end
end
