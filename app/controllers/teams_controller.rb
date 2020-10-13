class TeamsController < ApplicationController
  def show
    @team = Team.find_by(id: params[:id])
    render json: @team
  end

  def list
    @teams = Team.all
    render json: @teams
  end
end
