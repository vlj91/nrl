## Notes

* Mostly batch jobs, the data only needs to be scraped every few hours, so processing can occur in between games/days/rounds

## Pulling initial data

Run the jobs in order to scrape the initial data:

1. `TeamScraperJob`
2. `PlayerScraperJob`
3. `GameScraperJob`
4. `GameStatsScraperJob`

Alternatively, just run `RunAllJob`

## Things

### Predictions endpoints

#### `GET /prediction/:id`

Returns the predicted winner of a game. Provide game_id:

```json
{"predicted_winner":"home"}
```

#### `GET /predictions/accuracy`

Returns the current model validation accuracy:

```json
{"accuracy_percent":82.73}
```

#### `GET /predictions/probability/:id`

Returns the probabilities of each side winning a game. Provide game_id:

```json
{"away": 0.08881750275339861, "draw": 0.002411944486199366, "home": 0.9087705527604021}
```

#### `GET /predictions/odds/:id`

Returns the odds of each side winning a game. Provide game_id:

```json
{"away":2.8177114573036244,"draw":55.42335925179432,"home":1.5947459543327327}
```

#### `GET /predictions/features`

Returns the features used in the model:

```json
["home_team_wins","away_team_wins","home_team_drawn","away_team_drawn","home_team_losses","away_team_losses","home_team_home_game_wins","away_team_home_game_wins","home_team_away_game_wins","away_team_away_game_wins","result","month","day","stadium","city","home_team_avg_win_margin","home_team_avg_loss_margin","home_team_avg_errors_per_game","home_team_avg_tries_per_game","home_team_avg_goals_per_game","home_team_avg_goals_missed_per_game","home_team_avg_line_breaks_per_game","home_team_avg_penalties_per_game","home_team_avg_points_per_game","home_team_avg_kick_bombs_per_game","home_team_avg_forty_twenties_per_game","home_team_avg_sin_bins_per_game","home_team_total_tries","home_team_total_errors","home_team_total_penalties","home_team_total_goals","home_team_total_line_breaks","home_team_total_kick_bombs","home_team_total_forty_twenties","home_team_total_sin_bins","home_team_avg_send_offs_per_game","home_team_avg_offsides_per_game","home_team_avg_ball_strips_per_game","home_team_avg_professional_fouls_per_game","away_team_avg_win_margin","away_team_avg_loss_margin","away_team_avg_errors_per_game","away_team_avg_tries_per_game","away_team_avg_goals_per_game","away_team_avg_goals_missed_per_game","away_team_avg_line_breaks_per_game","away_team_avg_penalties_per_game","away_team_avg_points_per_game","away_team_avg_kick_bombs_per_game","away_team_avg_forty_twenties_per_game","away_team_avg_sin_bins_per_game","away_team_total_tries","away_team_total_errors","away_team_total_penalties","away_team_total_goals","away_team_total_line_breaks","away_team_total_kick_bombs","away_team_total_forty_twenties","away_team_total_sin_bins","away_team_avg_send_offs_per_game","away_team_avg_offsides_per_game","away_team_avg_ball_strips_per_game","away_team_avg_professional_fouls_per_game"]
```
