class Api::V1::GamesController < ApplicationController
  # /api/v1/games
	def index
		game = Game.all

		render json: game
	end

  # /api/v1/games/:season/:round
  def find
    game = Game.where(round: params[:round], season: params[:season])

    render json: game
  end

  # /api/v1/games/:id
	def show
    game = Game.find(params[:id])

    render json: game
	end
end
