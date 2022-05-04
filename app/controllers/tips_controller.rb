class TipsController < ApplicationController
  # /tips/:season/:round
  def index 
    @games = Game.where(season: params[:season], round: params[:round])
    @games = @games.order(kickoff_time: :asc)
  end
end
