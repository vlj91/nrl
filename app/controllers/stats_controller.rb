class StatsController < ApplicationController
  def index
    game_stats = GameStat.all.load_async.count
    player_stats = PlayerStat.all.load_async.count
    team_stats = TeamStat.all.load_async.count
    game_events = GameEvent.all.load_async.count
    players = Player.all.load_async.count
    games = Game.all.load_async.count

    render json: {
      game_stats: game_stats,
      player_stats: player_stats,
      team_stats: team_stats,
      game_events: game_events,
      players: players,
      games: games
    }
  end
end
