class GamesController < ApplicationController
  def index
    @games = Game.all.order(kickoff_time: :desc)
    @games = @games.where(season: params[:season]) if params[:season]
    @games = @games.where(round: params[:round]) if params[:round]

    respond_to do |format|
      format.json { render json: @games }

      format.csv do
        send_data @games.to_csv, filename: "games.csv"
      end
    end
  end

  def show
    @game = Game.find(params[:id])

    render json: @game
  end
end
