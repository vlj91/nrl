class PlayersController < ApplicationController
  def show
    @player = Player.find_by(params[:id])
    render json: @player
  end

  def list
    @players = Player.all
    render json: @players.to_json
  end
end
