class HomeController < ApplicationController
  def index
    @games = Game.all.load_async
    @players = Player.all.load_async
    @teams = Team.all.load_async
    @game_stats = GameStat.all.load_async
    @player_stats = PlayerStat.all.load_async
    @team_stats = TeamStat.all.load_async
    @game_events = GameEvent.all.load_async
  end
end
