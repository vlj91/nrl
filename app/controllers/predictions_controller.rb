class PredictionsController < ApplicationController
  def accuracy
  	render :json => ResultModel.new.accuracy
  end

  def show
  	game = Game.find(params[:id])
  	@prediction = ResultModel.new.predict(game)

  	render :json => {"predicted_winner": @prediction}
  end
end
