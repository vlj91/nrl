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
      @game = Game.distinct.pluck(:season)
    elsif params[:id] == 'rounds'
      @game = Game.distinct.pluck(:round)
    else
      @game = Game.find(params[:id])
    end

    render :json => @game
	end
end
