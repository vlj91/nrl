class GamesController < ApplicationController
  def index
    @games = Game.all.load_async
  end

  def show
  end
end
