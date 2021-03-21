class Api::V1::GamesController < ApplicationController
  # /api/v1/games
	def index
    game = Game.all.order('kickoff_time ASC')
    game = game.where(season: params[:season]) if params[:season]
    game = game.where(round: params[:round]) if params[:round]
    game = game.where(title: params[:title]) if params[:title]
    game = game.where(stadium: params[:stadium]) if params[:stadium]
    game = game.where(city: params[:city]) if params[:city]

    render json: game
	end

  # /api/v1/games/:id
	def show
    game = Game.find(params[:id])

    render json: game
	end
end
