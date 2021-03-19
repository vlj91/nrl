class Api::V1::PlayersController < ApplicationController
  # /api/v1/players
  def index
    player = Player.all

    render json: player
  end

  # /api/v1/players/:id
  def show
    player = Player.find(params[:id])

    render json: player
  end
end
