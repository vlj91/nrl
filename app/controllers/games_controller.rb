class GamesController < ApplicationController
  def show
    @game = Game.find_by(id: params[:id])
    render json: @game
  end

  def list
    if params[:round] == 'round' && params[:title]
      @games = Game.where(round: params[:title])
    else
      @games = Game.all
    end

    render json: @games
  end
end
