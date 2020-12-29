class TeamStatsUpdaterJob < ApplicationJob
  queue_as :default

  def update_avg_errors_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_errors_per_game'
    })

    errs = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids)
    for game in games do
      errs.push(game.game_events.where(team_id: team.id, event_type: 'Error').count)
    end

    team_stat.value = errs.sum.fdiv(errs.size).round(0)
    team_stat.save!
  end

  def update_avg_tries_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_tries_per_game'
    })

    tries = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids)
    for game in games do
      tries.push(game.game_events.where(team_id: team.id, event_type: 'Try').count)
    end

    team_stat.value = tries.sum.fdiv(tries.size).round(0)
    team_stat.save!
  end

  def perform(*args)
    for team in Team.all do
      update_avg_errors_per_game!(team)
      update_avg_tries_per_game!(team)
    end
  end
end
