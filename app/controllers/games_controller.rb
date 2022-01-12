class GamesController < ApplicationController
  def index
    @games = Game.all
    @game = Game.new
  end

  def list
    @games = Game.all
    @games = @games.where(season: params[:season]) if params[:sesason].present?
  end

  def show
    @game = Game.find(params[:id])
  end
end
