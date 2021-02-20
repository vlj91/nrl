class PlayersController < ApplicationController
  def list
  	@player = Player.all

  	render :json => @player
  end

  def show
  	@player = Player.find(params[:id])

  	render :json => @player
  end
end
