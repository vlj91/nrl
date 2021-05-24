class Api::V1::InfoController < ApplicationController
  def show
    resp = {
      current_round: current_round,
      current_season: current_season
    }

    render json: resp
  end

  private

  def current_round
    Game.where(played: false).first.round
  end

  def current_season
    Game.last.season
  end
end
