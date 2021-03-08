class GamesController < ApplicationController
	def list
		@game = Game.all

		render :json => @game
	end

  def find
    @game = Game.where(round: params[:round], season: params[:season])

    render :json => @game
  end

	def show
    if params[:id] == 'seasons'
      @game = Game.distinct.pluck(:season).sort
    elsif params[:id] == 'rounds'
      @game = Game.distinct.pluck(:round).sort
    elsif params[:id] == 'count'
      @game = { total_games: Game.count }
    else
      @game = Game.find(params[:id])
    end

    render :json => @game
	end
end
