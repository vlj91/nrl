class GameStatsUpdaterJob < ApplicationJob
  queue_as :default

  def update_team_tries!(game, side)
    team = GameTeam.find_by({
      game_id: game.id,
      side: side 
    })

    stat = GameStat.find_or_create_by({
      name: 'tries',
      team_id: team.id,
      game_id: game.id
    })

    stat.value = GameEvent.where(game_id: game.id, team_id: team.id, event_type: 'Try').count
    stat.save!
  end

  def update_team_goals!(game, side)
    team = GameTeam.find_by({
      game_id: game.id,
      side: side
    })

    stat = GameStat.find_or_create_by({
      name: 'goals',
      team_id: team.id,
      game_id: game.id
    })

    stat.value = GameEvent.where(game_id: game.id, team_id: team.id, event_type: 'Goal').count
    stat.save!
  end

  def perform(*args)
    for game in Game.all do
      update_team_tries!(game, 'home')
      update_team_tries!(game, 'away')
      update_team_goals!(game, 'home')
      update_team_goals!(game, 'away')
    end
  end
end
