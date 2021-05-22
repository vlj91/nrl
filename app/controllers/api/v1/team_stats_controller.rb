class Api::V1::TeamStatsController < ApplicationController
  # /api/v1/team/stats
  def index
    result = TeamStat.all
    result = result.where(name: params[:name]) if params[:name]
    result = result.where(team_id: params[:team_id]) if params[:team_id]

    resp = { team_stats: result }
    render json: resp
  end

  # /api/v1/team/stats/:id
  def show
    result = TeamStat.find(params[:id])

    render json: result
  end
end