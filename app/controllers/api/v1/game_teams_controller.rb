class Api::V1::GameTeamsController < ApplicationController
  # /api/v1/game/teams
  def index
    result = GameTeam.all
    result = result.where(team_id: params[:team_id]) if params[:team_id]
    result = result.where(game_id: params[:game_id]) if params[:game_id]
    result = result.where(side: params[:side]) if params[:side]

    render json: result
  end

  # /api/v1/game/teams/:id
  def show
    result = GameTeam.find(params[:id])

    render json: result
  end
end