class PredictionsController < ApplicationController
  # /predictions/accuracy
  def accuracy
    accuracy = (ResultModel.new.accuracy[:accuracy] * 100).round(2)

    render :json => {"accuracy_percent": accuracy}
  end

  # /predction/:id
  def show
  	game = Game.find(params[:id])
  	@prediction = ResultModel.new.predict(game)

  	render :json => {"predicted_winner": @prediction}
  end
end
