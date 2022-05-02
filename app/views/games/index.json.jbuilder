json.array! @games do |game|
  # game info
  json.round game.round
  json.season game.season
  json.kickoff_time game.kickoff_time
  json.city game.city
  json.stadium game.stadium

  # teams
  json.home_team_name game.home_team.team.name
  json.away_team_name game.away_team.team.name

  # actual
  json.win_margin game.win_margin
  json.total_tries game.total_tries
  json.total_points game.total_points
  json.result game.result

  # predictions
  json.predicted_result game.predicted_result
  json.predicted_win_margin game.predicted_win_margin
  json.predicted_total_tries game.predicted_total_tries
  json.predicted_total_points game.predicted_total_points
end
