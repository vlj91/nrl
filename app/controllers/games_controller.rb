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
		@game = Game.find(params[:id])

		render :json => @game
	end

  def seasons
    @season = Game.distinct.pluck(:season)

    render :json => @season
  end

  def rounds
    @round = Game.distinct.pluck(:round)
    
    render :json => @round
  end
end
