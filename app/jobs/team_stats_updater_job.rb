class TeamStatsUpdaterJob < ApplicationJob
  queue_as :default

  # TODO: should the avg points per game be calculated by:
  # - adding avg tries per game and avg goals per game together
  # - grabbing all game total points and averaging that number
  def update_avg_points_per_game!(team)
    avg_tries_per_game = TeamStat.find_by(team_id: team.id, name: 'avg_tries_per_game').value
    avg_goals_per_game = TeamStat.find_by(team_id: team.id, name: 'avg_goals_per_game').value

    stat = TeamStat.find_or_create_by({team_id: team.id, name: 'avg_points_per_game'})
    avg_points_per_game = ((avg_tries_per_game * 4) + (avg_goals_per_game * 2))
    stat.value = avg_points_per_game
    stat.save!
  end

  def update_avg_win_margin!(team)
    win_game_margins = []

    gt = GameTeam.where(team_id: team.id)
    for g in gt do
      # we don't want to calculate margins for games that haven't been played
      games = Game.where(id: g.game_id, played: true, result: ['home', 'away', 'draw'])
      next if games.count == 0
      game = games.first

      if game.result == g.side
        if g.side == 'home'
          win_margin = game.home_team_points - game.away_team_points
        elsif g.side == 'away'
          win_margin = game.away_team_points - game.home_team_points
        end

        win_game_margins.push(win_margin)
      end
    end

    stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_win_margin'
    })

    stat.value = win_game_margins.sum.fdiv(win_game_margins.size).round(0)
    stat.save!
  end

  def update_avg_loss_margin!(team)
    loss_game_margins = []

    gt = GameTeam.where(team_id: team.id)
    for g in gt do
      # we don't want to calculate margins for games that haven't been played
      games = Game.where(id: g.game_id, played: true, result: ['home', 'away', 'draw'])
      next if games.count == 0
      game = games.first

      if game.result != g.side && game.result != 'draw'
        if g.side == 'home'
          loss_margin = game.away_team_points - game.home_team_points
        elsif g.side == 'away'
          loss_margin = game.home_team_points - game.away_team_points
        end

        loss_game_margins.push(loss_margin)
      end
    end

    stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_loss_margin'
    })

    stat.value = loss_game_margins.sum.fdiv(loss_game_margins.size).round(0)
    stat.save!
  end

  def update_avg_errors_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_errors_per_game'
    })

    errs = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    # we don't want to calculate margins for games that haven't been played
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])
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
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])
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
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])
    for game in games do
      goals.push(game.game_events.where(team_id: team.id, event_type: 'Goal').count)
    end

    team_stat.value = goals.sum.fdiv(goals.size).round(0)
    team_stat.save!
  end

  def update_avg_goals_missed_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_goals_missed_per_game'
    })

    goals_missed = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      goals_missed.push(game.game_events.where(team_id: team.id, event_type: 'GoalMissed').count)
    end

    team_stat.value = goals_missed.sum.fdiv(goals_missed.size).round(0)
    team_stat.save!
  end

  def update_avg_line_breaks_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_line_breaks_per_game'
    })

    line_breaks = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])
    for game in games do
      line_breaks.push(game.game_events.where(team_id: team.id, event_type: 'LineBreak').count)
    end

    team_stat.value = line_breaks.sum.fdiv(line_breaks.size).round(0)
    team_stat.save!
  end

  def update_avg_kick_bombs_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_kick_bombs_per_game'
    })

    kick_bombs = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      kick_bombs.push(game.game_events.where(team_id: team.id, event_type: 'KickBomb').count)
    end

    team_stat.value = kick_bombs.sum.fdiv(kick_bombs.size).round(0)
    team_stat.save!
  end

  def update_avg_forty_twenties_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_forty_twenties_per_game'
    })

    forty_twenties = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      forty_twenties.push(game.game_events.where(team_id: team.id, event_type: 'FortyTwenty').count)
    end

    team_stat.value = forty_twenties.sum.fdiv(forty_twenties.size).round(0)
    team_stat.save!
  end

  def update_avg_sin_bins_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_sin_bins_per_game'
    })

    sin_bins = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      sin_bins.push(game.game_events.where(team_id: team.id, event_type: 'SinBin').count)
    end

    team_stat.value = sin_bins.sum.fdiv(sin_bins.size).round(0)
    team_stat.save!
  end

  def update_avg_send_offs_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_send_offs_per_game'
    })

    send_offs = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      send_offs.push(game.game_events.where(team_id: team.id, event_type: 'Penalty', name: 'Sent Off').count)
    end

    team_stat.value = send_offs.sum.fdiv(send_offs.size).round(0)
    team_stat.save!
  end

  def update_avg_offsides_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_offsides_per_game'
    })

    offsides = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      offside_penalty_types = ['Penalty - Offside General', 'Penalty - Offside inside 10m']
      offsides.push(game.game_events.where(team_id: team.id, event_type: 'Penalty', name: offside_penalty_types).count)
    end

    team_stat.value = offsides.sum.fdiv(offsides.size).round(0)
    team_stat.save!
  end

  def update_avg_ball_strips_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_ball_strips_per_game'
    })

    ball_strips = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      ball_strips.push(game.game_events.where(team_id: team.id, event_type: 'Penalty', name: 'Penalty - Ball Strip').count)
    end

    team_stat.value = ball_strips.sum.fdiv(ball_strips.size).round(0)
    team_stat.save!
  end

  def update_avg_professional_fouls_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_professional_fouls_per_game'
    })

    professional_fouls = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      professional_fouls.push(game.game_events.where(team_id: team.id, event_type: 'Penalty', name: 'Penalty - Professional Foul').count)
    end

    team_stat.value = professional_fouls.sum.fdiv(professional_fouls.size).round(0)
    team_stat.save!
  end

  def update_avg_dangerous_tackles_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_dangerous_tackles_per_game'
    })

    dangerous_tackles = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      dangerous_tackles.push(game.game_events.where(team_id: team.id, event_type: 'Penalty', name: 'Penalty - Dangerous Tackle').count)
    end
    
    team_stat.value = dangerous_tackles.sum.fdiv(dangerous_tackles.size).round(0)
    team_stat.save!
  end

  def update_avg_conversions_made_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_conversions_made_per_game'
    })

    conversions_made = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    for game in games do
      conversions_made.push(game.game_events.where(team_id: team.id, event_type: 'Goal', name: 'Conversion-Made').count)
    end

    team_stat.value = conversions_made.sum.fdiv(conversions_made.size).round(0)
    team_stat.save!
  end

  def update_avg_penalties_per_game!(team)
    team_stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_penalties_per_game'
    })

    penalties = []
    game_ids = GameTeam.where(team_id: team.id).map(&:game_id)
    games = Game.where(id: game_ids, played: true, result: ['home', 'away', 'draw'])

    penalty_types = [
      'Penalty',
      'Penalty - Slow Peel',
      'Penalty - Early Tackle',
      'Penalty - Pressure on Kicker',
      'Penalty - Flop',
      'Penalty - Leg Pull',
      'Penalty - 2nd Effort',
      'Penalty - Dangerous Tackle',
      'Penalty - Hand in the Ruck',
      'Penalty - Shoulder Charge',
      'Penalty - Offside Downtown',
      'Penalty - Holding Down',
      'Penalty - Ball Strip',
      'Penalty - Offside inside 10m',
      'Penalty - Crowding',
      'Penalty - Offside General',
      'Penalty - Marker Not Square',
      'Penalty - Grappel',
      'Penalty - Professional Foul',
      'Penalty - Lying in the Ruck',
      'Penalty - Scrum Infringement',
      'Penalty - Obstruction',
      'Penalty - Escorts',
      'Penalty - Holding Back',
      'Penalty - Late Tackle',
      'Penalty - Verbal Dissent',
      'Penalty - Working on the Ground',
      'Penalty - Punching',
      'Penalties - Other',
      'Sent Off'
    ]

    for game in games do
      penalties.push(game.game_events.where(team_id: team.id, event_type: penalty_types).count)
    end

    team_stat.value = penalties.sum.fdiv(penalties.size).round(0)
    team_stat.save!
  end

  def update_total_game_first_tries!(team)
    stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'total_game_first_tries'
    })

    game_first_tries = []

    for game in team.games do
      game_events = game.game_events.where(event_type: 'Try')
      next if game_events.length == 0
      first_try_event = game_events.where(event_type: 'Try').order(:game_seconds).first
      game_first_tries.push(first_try_event.id) if first_try_event.team_id == team_id
    end
    
    stat.value = game_first_tries.length
    stat.save!
  end

  def update_avg_first_try_minute!(team)
    stat = TeamStat.find_or_create_by({
      team_id: team.id,
      name: 'avg_game_first_try_minute'
    })

    game_first_try_minutes = []

    for game in team.games do
      game_events = game.game_events.where(event_type: 'Try', team_id: team_id)
      next if game_events.length == 0
      first_try_game_seconds = game_events.where(event_type: 'Try', team_id: team_id).order(:game_seconds).first.game_seconds
      first_try_minute = first_try_game_seconds / 60
      game_first_try_minutes.push(first_try_minute)
    end

    stat.value = game_first_try_minutes.sum.fdiv(conversions_made.size).round(0)
    stat.save!
  end

  def update_total!(event_type, team_id, stat_name)
    stat = TeamStat.find_or_create_by({
      team_id: team_id,
      name: stat_name
    })

    stat.value = GameEvent.where({
      event_type: event_type,
      team_id: team_id
    }).count
    stat.save!
  end

  def perform(*args)
    for team in Team.all do
      update_avg_win_margin!(team)
      update_avg_loss_margin!(team)
      update_avg_errors_per_game!(team)
      update_avg_tries_per_game!(team)
      update_avg_goals_per_game!(team)
      update_avg_goals_missed_per_game!(team)
      update_avg_line_breaks_per_game!(team)
      update_avg_penalties_per_game!(team)
      update_avg_points_per_game!(team)
      update_avg_kick_bombs_per_game!(team)
      update_avg_forty_twenties_per_game!(team)
      update_avg_sin_bins_per_game!(team)
      update_avg_send_offs_per_game!(team)
      update_avg_offsides_per_game!(team)
      update_avg_ball_strips_per_game!(team)
      update_avg_professional_fouls_per_game!(team)
      update_avg_conversions_made_per_game!(team)
      update_avg_first_try_minute!(team)
      update_total_game_first_tries!(team)
      update_total!('Try', team.id, 'total_tries')
      update_total!('Error', team.id, 'total_errors')
      update_total!('Penalty', team.id, 'total_penalties')
      update_total!('Goal', team.id, 'total_goals')
      update_total!('LineBreak', team.id, 'total_line_breaks')
      update_total!('KickBomb', team.id, 'total_kick_bombs')
      update_total!('FortyTwenty', team.id, 'total_forty_twenties')
      update_total!('SinBin', team.id, 'total_sin_bins')
    end
  end
end
