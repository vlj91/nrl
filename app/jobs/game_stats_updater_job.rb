class GameStatsUpdaterJob < ApplicationJob
  queue_as :default

  def update_team_stat!(game, side, stat, event_type)
    game_team = GameTeam.find_by({
      game_id: game.id,
      side: side
    })

    stat = GameStat.find_or_create_by({
      name: stat,
      game_id: game.id,
      team_id: game_team.team_id
    })

    stat.value = game.game_events.where(team_id: game_team.team_id, event_type: event_type).count
    stat.save!
  end

  def perform(*args)
    for game in Game.all do
      update_team_stat!(game, 'home', 'tries', 'Try')
      update_team_stat!(game, 'away', 'tries', 'Try')
      update_team_stat!(game, 'home', 'goals', 'Goal')
      update_team_stat!(game, 'away', 'goals', 'Goal')
    end
  end
end
