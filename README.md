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
{
  "predicted_result": "home",
  "features": {
    "home_team_wins": 11,
    "away_team_wins": 5,
    "home_team_drawn": 11,
    "away_team_drawn": 5,
    "home_team_losses": 9,
    "away_team_losses": 15,
    "home_team_home_game_wins": 7,
    "away_team_home_game_wins": 3,
    "home_team_away_game_wins": 4,
    "away_team_away_game_wins": 2,
    "result": "home",
    "month": "Aug",
    "day": "Sun",
    "stadium": "McDonald Jones Stadium",
    "city": "Newcastle",
    "home_team_avg_win_margin": 17,
    "home_team_avg_loss_margin": 18,
    "home_team_avg_errors_per_game": 10,
    "home_team_avg_tries_per_game": 4,
    "home_team_avg_goals_per_game": 3,
    "home_team_avg_goals_missed_per_game": 1,
    "home_team_avg_line_breaks_per_game": 4,
    "home_team_avg_penalties_per_game": 5,
    "home_team_avg_points_per_game": 22,
    "home_team_avg_kick_bombs_per_game": 6,
    "home_team_avg_forty_twenties_per_game": 0,
    "home_team_avg_sin_bins_per_game": 0,
    "home_team_total_tries": 78,
    "home_team_total_errors": 217,
    "home_team_total_penalties": 102,
    "home_team_total_goals": 65,
    "home_team_total_line_breaks": 84,
    "home_team_total_kick_bombs": 119,
    "home_team_total_forty_twenties": 2,
    "home_team_total_sin_bins": 3,
    "home_team_avg_send_offs_per_game": 0,
    "home_team_avg_offsides_per_game": 1,
    "home_team_avg_ball_strips_per_game": 0,
    "home_team_avg_professional_fouls_per_game": 0,
    "away_team_avg_win_margin": 14,
    "away_team_avg_loss_margin": 15,
    "away_team_avg_errors_per_game": 12,
    "away_team_avg_tries_per_game": 3,
    "away_team_avg_goals_per_game": 3,
    "away_team_avg_goals_missed_per_game": 1,
    "away_team_avg_line_breaks_per_game": 3,
    "away_team_avg_penalties_per_game": 5,
    "away_team_avg_points_per_game": 18,
    "away_team_avg_kick_bombs_per_game": 4,
    "away_team_avg_forty_twenties_per_game": 0,
    "away_team_avg_sin_bins_per_game": 0,
    "away_team_total_tries": 67,
    "away_team_total_errors": 235,
    "away_team_total_penalties": 99,
    "away_team_total_goals": 51,
    "away_team_total_line_breaks": 66,
    "away_team_total_kick_bombs": 82,
    "away_team_total_forty_twenties": 1,
    "away_team_total_sin_bins": 6,
    "away_team_avg_send_offs_per_game": 0,
    "away_team_avg_offsides_per_game": 1,
    "away_team_avg_ball_strips_per_game": 0,
    "away_team_avg_professional_fouls_per_game": 0
  }
}
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
[
  "home_team_wins",
  "away_team_wins",
  "home_team_drawn",
  "away_team_drawn",
  "home_team_losses",
  "away_team_losses",
  "home_team_home_game_wins",
  "away_team_home_game_wins",
  "home_team_away_game_wins",
  "away_team_away_game_wins",
  "result",
  "month",
  "day",
  "stadium",
  "city",
  "home_team_avg_win_margin",
  "home_team_avg_loss_margin",
  "home_team_avg_errors_per_game",
  "home_team_avg_tries_per_game",
  "home_team_avg_goals_per_game",
  "home_team_avg_goals_missed_per_game",
  "home_team_avg_line_breaks_per_game",
  "home_team_avg_penalties_per_game",
  "home_team_avg_points_per_game",
  "home_team_avg_kick_bombs_per_game",
  "home_team_avg_forty_twenties_per_game",
  "home_team_avg_sin_bins_per_game",
  "home_team_total_tries",
  "home_team_total_errors",
  "home_team_total_penalties",
  "home_team_total_goals",
  "home_team_total_line_breaks",
  "home_team_total_kick_bombs",
  "home_team_total_forty_twenties",
  "home_team_total_sin_bins",
  "home_team_avg_send_offs_per_game",
  "home_team_avg_offsides_per_game",
  "home_team_avg_ball_strips_per_game",
  "home_team_avg_professional_fouls_per_game",
  "away_team_avg_win_margin",
  "away_team_avg_loss_margin",
  "away_team_avg_errors_per_game",
  "away_team_avg_tries_per_game",
  "away_team_avg_goals_per_game",
  "away_team_avg_goals_missed_per_game",
  "away_team_avg_line_breaks_per_game",
  "away_team_avg_penalties_per_game",
  "away_team_avg_points_per_game",
  "away_team_avg_kick_bombs_per_game",
  "away_team_avg_forty_twenties_per_game",
  "away_team_avg_sin_bins_per_game",
  "away_team_total_tries",
  "away_team_total_errors",
  "away_team_total_penalties",
  "away_team_total_goals",
  "away_team_total_line_breaks",
  "away_team_total_kick_bombs",
  "away_team_total_forty_twenties",
  "away_team_total_sin_bins",
  "away_team_avg_send_offs_per_game",
  "away_team_avg_offsides_per_game",
  "away_team_avg_ball_strips_per_game",
  "away_team_avg_professional_fouls_per_game"
]
```

#### `GET /predictions/:season/:round`

Returns the predictions for a given round:

```json
{
  "round": "7",
  "season": "2020",
  "predictions": [
    {
      "title": "panthers-v-rabbitohs",
      "game_id": 1274,
      "predicted_result": "home",
      "probability": {
        "away": 0.17704719592535545,
        "draw": 0.024206808634601226,
        "home": 0.7987459954400433
      }
    },
    {
      "title": "bulldogs-v-wests-tigers",
      "game_id": 1281,
      "predicted_result": "away",
      "probability": {
        "away": 0.7619705664860235,
        "draw": 0.001481155236987007,
        "home": 0.23654827827698943
      }
    },
    {
      "title": "storm-v-warriors",
      "game_id": 1275,
      "predicted_result": "home",
      "probability": {
        "away": 0.06259048567789202,
        "draw": 0.0026326377128429264,
        "home": 0.9347768766092651
      }
    },
    {
      "title": "roosters-v-dragons",
      "game_id": 1276,
      "predicted_result": "home",
      "probability": {
        "away": 0.21533703035534948,
        "draw": 0.0016074155528502765,
        "home": 0.7830555540918003
      }
    },
    {
      "title": "cowboys-v-knights",
      "game_id": 1277,
      "predicted_result": "away",
      "probability": {
        "away": 0.8520243478588441,
        "draw": 0.013906022367229794,
        "home": 0.13406962977392617
      }
    },
    {
      "title": "broncos-v-titans",
      "game_id": 1278,
      "predicted_result": "away",
      "probability": {
        "away": 0.8255937468544338,
        "draw": 0.002885492991071954,
        "home": 0.17152076015449438
      }
    },
    {
      "title": "eels-v-raiders",
      "game_id": 1279,
      "predicted_result": "home",
      "probability": {
        "away": 0.4871542164640679,
        "draw": 0.001818842128229266,
        "home": 0.5110269414077029
      }
    },
    {
      "title": "sea-eagles-v-sharks",
      "game_id": 1280,
      "predicted_result": "away",
      "probability": {
        "away": 0.7672856418744509,
        "draw": 0.0012229172464755646,
        "home": 0.23149144087907342
      }
    }
  ]
}
```
