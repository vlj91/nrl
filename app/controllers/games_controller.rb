class GamesController < ApplicationController
	def list
		@game = Game.all

		render :json => @game
	end

	def show
		@game = Game.find(params[:id])

		render :json => @game
	end
end
