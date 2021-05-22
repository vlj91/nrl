class Api::V1::GameStatsController < ApplicationController
  # /api/v1/game/stats
  def index
    stat = GameStat.all
    stat = stat.where(game_id: params[:game_id]) if params[:game_id]
    stat = stat.where(team_id: params[:game_id]) if params[:team_id]
    stat = stat.where(name: params[:name]) if params[:name]

    resp = { game_stats: stat }
    render json: stat
  end

  # /api/v1/game/stats/:id
  def show
    stat = GameStat.find(params[:id])

    render json: stat
  end
end