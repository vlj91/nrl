class Api::V1::TeamsController < ApplicationController
  def index
    team = Team.all

    render json: team
  end

  def show
    team = Team.find(params[:id])

    render json: team
  end
end
