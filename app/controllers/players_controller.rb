class PlayersController < ApplicationController
  def show
    @player = Player.find_by(id: params[:id])

    render json: @player
  end

  def list
    if params[:team]
      @players = Team.find_by(name: params[:team]).players
    elsif params[:first_name] && params[:last_name]
      @players = Player.where(first_name: params[:first_name], last_name: params[:last_name])
    else
      @players = Player.all
    end

    render json: @players
  end
end
