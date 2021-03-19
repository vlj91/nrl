class Api::V1::GamesController < ApplicationController
	def index
		game = Game.all.order('date ASC')

		render json: game
	end

  def find
    game = Game.where(round: params[:round], season: params[:season]).order('date ASC')

    render json: game
  end

	def show
    game = Game.find(params[:id])

    render json: game
	end
end
