class PredictionsController < ApplicationController
  def show
  	game = Game.find(params[:id])
  	@prediction = ResultModel.new.predict(game)

  	render :json => @prediction
  end
end
