class GamesController < ApplicationController
	def list
		@game = Game.all

		render :json => @game
	end

  def find
    if params[:id] == 'seasons'
      @game = Game.distinct.pluck(:season)
    elsif params[:id] == 'rounds'
      @game = Game.distinct.pluck(:round)
    else
      @game = Game.where(round: params[:round], season: params[:season])
    end

    render :json => @game
  end

	def show
		@game = Game.find(params[:id])

		render :json => @game
	end
end
