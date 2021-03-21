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

  def update_total_points!(game, side)
    game_team = GameTeam.find_by({
      game_id: game.id,
      side: side
    })

    tries = GameStat.find_by({
      name: 'tries',
      game_id: game.id,
      team_id: game_team.team_id
    }).value

    goals = GameStat.find_by({
      name: 'goals',
      game_id: game.id,
      team_id: game_team.team_id
    }).value

    points = (tries * 4) + (goals * 2)

    stat = GameStat.find_or_create_by({
      name: 'points',
      game_id: game.id,
      team_id: game_team.team_id
    })

    stat.value = points
    stat.save!
  end

  def perform(*args)
    for game in Game.all.where(played: true, scraped: true) do
      update_team_stat!(game, 'home', 'tries', 'Try')
      update_team_stat!(game, 'away', 'tries', 'Try')
      update_team_stat!(game, 'home', 'goals', 'Goal')
      update_team_stat!(game, 'away', 'goals', 'Goal')
      update_total_points!(game, 'home')
      update_total_points!(game, 'away')
    end
  end
end
