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

  def update_avg_goals_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_goals_per_game'
    })

    goals = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids)
    for game in games do
      goals.push(game.game_events.where(team_id: team.id, event_type: 'Penalty').count)
    end

    team_stat.value = goals.sum.fdiv(goals.size).round(0)
    team_stat.save!
  end

  def update_avg_line_breaks_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_line_breaks_per_game'
    })

    line_breaks = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids)
    for game in games do
      line_breaks.push(game.game_events.where(team_id: team.id, event_type: 'LineBreak').count)
    end

    team_stat.value = line_breaks.sum.fdiv(line_breaks.size).round(0)
    team_stat.save!
  end

  def update_total_tries!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'total_tries'
    })

    team_stat.value = GameEvent.where(event_type: 'Try', team_id: team.id).count
    team_stat.save!
  end

  def update_total_errors!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'total_errors'
    })

    team_stat.value = GameEvent.where(event_type: 'Error', team_id: team.id).count
    team_stat.save!
  end

  def update_total_penalties!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'total_penalties'
    })

    team_stat.value = GameEvent.where(event_type: 'Penalty', team_id: team.id).count
    team_stat.save!
  end

  def update_total_goals!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'total_goals'
    })

    team_stat.value = GameEvent.where(event_type: 'Goal', team_id: team.id).count
    team_stat.save!
  end

  def update_total_line_breaks!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'total_line_breaks'
    })

    team_stat.value = GameEvent.where(event_type: 'LineBreak', team_id: team.id).count
    team_stat.save!
  end

  def perform(*args)
    for team in Team.all do
      update_avg_errors_per_game!(team)
      update_avg_tries_per_game!(team)
      update_avg_goals_per_game!(team)
      update_avg_line_breaks_per_game!(team)
      update_total_tries!(team)
      update_total_errors!(team)
      update_total_penalties!(team)
      update_total_goals!(team)
      update_total_line_breaks!(team)
    end
  end
end
