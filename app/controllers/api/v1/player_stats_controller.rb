class Api::V1::PlayerStatsController < ApplicationController
  # /api/v1/player/stats
  def index
    result = PlayerStat.all
    result = result.where(name: params[:name]) if params[:name]
    result = result.where(player_id: params[:player_id]) if params[:player_id]

    render json: result
  end

  # /api/v1/player/stats/:id
  def show
    result = PlayerStat.find(params[:id])

    render json: result
  end
end