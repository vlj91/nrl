class GamesController < ApplicationController
  def show
    @game = Game.find_by(params[:id])
    render json: @game.to_json
  end

  def list
    @games = Game.all
    render json: @games.to_json
  end
end
