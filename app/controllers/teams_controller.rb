class TeamsController < ApplicationController
  def show
    @team = Team.where(id: params[:id]).or(Team.where(slug: params[:id])).first
    render json: @team
  end

  def list
    if params[:compare]
      @teams = Team.where(slug: [params[:compare].split(',')])
    else
      @teams = Team.all
    end
    render json: @teams
  end
end