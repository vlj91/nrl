class Api::V1::GamesController < ApplicationController
	def list
		@game = Game.all

		render :json => @game
	end

  def find
    @game = Game.where(round: params[:round], season: params[:season]).order('date ASC')

    if params[:format] == 'batch' && params[:amount]
      results = @game.map(&:predicted_result).map { |x| x.split('')[0] }.join('/').upcase!
      render :text => "YF-PW-00-#{params[:amount]}/#{results}"
    else
      render :json => @game
    end
  end

	def show
    if params[:id] == 'seasons'
      @game = Game.distinct.pluck(:season).sort
    elsif params[:id] == 'rounds'
      @game = Game.distinct.pluck(:round).sort
    elsif params[:id] == 'count'
      @game = { total_games: Game.count }
    else
      @game = Game.find(params[:id])
    end

    render :json => @game
	end
end
