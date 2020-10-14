class TeamsController < ApplicationController
  def show
    @team = Team.where(id: params[:id]).or(Team.where(slug: params[:id])).first
    render json: @team
  end

  def list
    @teams = Team.all
    render json: @teams
  end
end