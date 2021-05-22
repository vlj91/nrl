class Api::V1::PlayersController < ApplicationController
  # /api/v1/players
  def index
    player = Player.all
    player = player.where(first_name: params[:first_name]) if params[:first_name]
    player = player.where(last_name: params[:last_name]) if params[:last_name]
    player = player.where(team_id: params[:team_id]) if params[:team_id]

    resp = { players: player }
    render json: resp
  end

  # /api/v1/players/:id
  def show
    player = Player.find(params[:id])

    render json: player
  end
end
