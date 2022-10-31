json.array! @game_events do |game_event|
  json.team_name game_event.team.name
  json.game_minute game_event.game_seconds / 60
  json.name game_event.name
  json.player_name "#{game_event.player.first_name} #{game_event.player.last_name}"
  json.game_date game_event.game.kickoff_time.to_date
end