class Api::V1::PlayersController < ApplicationController
  def index
    player = Player.all

    render json: player
  end

  def show
    player = Player.find(params[:id])

    render json: player
  end
end
