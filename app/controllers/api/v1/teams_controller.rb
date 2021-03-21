class Api::V1::TeamsController < ApplicationController
  # /api/v1/teams
  def index
    team = Team.all
    team = team.where(name: params[:name]) if params[:name]
    team = team.where(nickname: params[:nickname]) if params[:nickname]

    render json: team
  end

  # /api/v1/teams/:id
  def show
    team = Team.find(params[:id])

    render json: team
  end
end
