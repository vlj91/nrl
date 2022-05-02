class GamesController < ApplicationController
  def index
    @games = Game.all.order(kickoff_time: :desc)
    @games = @games.where(season: params[:season]) if params[:season]
    @games = @games.where(round: params[:round]) if params[:round]
  end

  def show
    @game = Game.find(params[:id])

    render json: @game
  end
end
