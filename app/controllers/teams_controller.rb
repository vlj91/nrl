class TeamsController < ApplicationController
  def show
    @team = Team.find_by(params[:id])
    render json: @team
  end

  def list
    @teams = Team.all
    render json: @teams.to_json
  end
end
