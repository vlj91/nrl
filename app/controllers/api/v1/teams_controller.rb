class Api::V1::TeamsController < ApplicationController
  # /api/v1/teams
  def index
    team = Team.all

    render json: team
  end

  # /api/v1/teams/:id
  def show
    team = Team.find(params[:id])

    render json: team
  end
end
