class GamesController < ApplicationController
  def show
    @game = Game.find_by(params[:id])
    render :json => @game, :except => [:id, :created_at, :updated_at, :scraped]
  end

  def list
    @games = Game.all
    render :json => @games, :except => [:id, :created_at, :updated_at, :scraped]
  end
end
