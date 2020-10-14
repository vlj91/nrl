class GamesController < ApplicationController
  def show

    if params[:id]
      @game = Game.find_by(id: params[:id])
    elsif params[:round] && params[:title]
      id = Game.where(round: params[:round]).select { |i| i.title == params[:title] }.first.id
      @game = Game.find_by(id: id)
    end

    render json: @game
  end

  def list
    @games = Game.all
    render json: @games
  end
end
