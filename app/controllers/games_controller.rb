class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
  end
end
